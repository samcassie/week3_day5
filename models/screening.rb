require_relative('../db/sql_runner.rb')

class Screening

    attr_reader :id
    attr_accessor :film_id, :tickets_sold, :start_time

    def initialize(options)
        @id = options['id'].to_i() if options['id']
        @film_id = options['film_id'].to_i()
        @tickets_sold = options['tickets_sold'].to_i()
        @start_time = options['start_time']
    end

    def save
        sql = "INSERT INTO screenings (
        film_id,
        tickets_sold,
        start_time
        )
        VALUES(
        $1, $2, $3 )
        RETURNING id"
        values = [@film_id, @tickets_sold, @start_time]
        screening = SqlRunner.run(sql, values).first
        @id = screening['id'].to_i()
    end

    def update()
        sql = "UPDATE screenings SET (
            tickets_sold,
            start_time
        ) =
        (
            $1, $2
        )
        WHERE id = $3"
        values = [@tickets_sold, @start_time, @id]
        SqlRunner.run(sql, values)
    end

    def self.all()
        sql = "SELECT * FROM screenings"
        screenings = SqlRunner.run(sql)
        result = screenings.map{|screening| Screening.new(screening)}
        return result
    end

    def self.delete_all()
        sql = "DELETE FROM screenings"
        SqlRunner.run(sql)
    end

    def self.most_popular_film()
        sql = "SELECT * FROM screenings
        ORDER BY tickets_sold DESC"
        screening = SqlRunner.run(sql).first
        return screening
    end
end
