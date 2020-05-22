require_relative('../db/sql_runner.rb')

class Film

    attr_reader :id
    attr_accessor :title, :price

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @title = options['title']
        @price = options['price'].to_i()
    end

    def save
        sql = "INSERT INTO films (
        title,
        price
        )
        VALUES(
        $1, $2 )
        RETURNING id"
        values = [@title, @price]
        film = SqlRunner.run(sql, values).first
        @id = film['id'].to_i()
    end

    def update()
        sql = "UPDATE films SET (
            title,
            price
        ) =
        (
            $1, $2
        )
        WHERE id = $3"
        values = [@title, @price, @id]
        SqlRunner.run(sql, values)
    end

    def customers()
        sql = "SELECT * FROM customers
        INNER JOIN tickets on tickets.customer_id = customers.id
        WHERE film_id = $1"
        values = [@id]
        result = SqlRunner.run(sql, values)
        customers = result.map{|customer| Customer.new(customer)}
        return customers
    end

    def most_popular_time()
        sql = "SELECT * FROM films
        INNER JOIN screenings ON films.id = screenings.film_id
        WHERE film_id = $1
        ORDER BY screenings.tickets_sold DESC"
        values = [@id]
        result = SqlRunner.run(sql, values).first
        return result
    end

    def self.all()
        sql = "SELECT * FROM films"
        films = SqlRunner.run(sql)
        result = films.map{|film| Film.new(film)}
        return result
    end

    def self.delete_all()
        sql = "DELETE FROM films"
        SqlRunner.run(sql)
    end

end
