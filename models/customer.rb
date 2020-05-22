require_relative('../db/sql_runner.rb')

class Customer

    attr_reader :id
    attr_accessor :name, :funds

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @name = options['name']
        @funds = options['funds'].to_i()
    end

    def save
        sql = "INSERT INTO customers (
        name,
        funds
        )
        VALUES(
        $1, $2 )
        RETURNING id"
        values = [@name, @funds]
        customer = SqlRunner.run(sql, values).first
        @id = customer['id'].to_i()
    end

    def self.all()
        sql = "SELECT * FROM customers"
        customers = SqlRunner.run(sql)
        result = customers.map{|customer| Customer.new(customer)}
        return result
    end

    def self.delete_all()
        sql = "DELETE FROM customers"
        SqlRunner.run(sql)
    end

    def update()
        sql = "UPDATE customers SET (
            name,
            funds
            ) =
            (
                $1, $2
            )
            WHERE id = $3"
            values = [@name, @funds]
            SqlRunner.run(sql, values)
    end

    def films()
        sql = "SELECT * FROM films
        INNER JOIN tickets on tickets.film_id = films.id
        WHERE customer_id = $1"
        values = [@id]
        result = SqlRunner.run(sql, values)
        films = result.map{|film| Film.new(film)}
        return films
    end


end
