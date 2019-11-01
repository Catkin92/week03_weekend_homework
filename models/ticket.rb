require_relative('../db/sql_runner.rb')

class Ticket

  attr_accessor :film_id, :customer_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id']
    @customer_id = options['customer_id']
  end

  def save
    sql = "INSERT INTO tickets (film_id, customer_id)
    VALUES ($1, $2)
    RETURNING id"
    values = [@film_id, @customer_id]
    save = SqlRunner.run(sql, values)[0]
    @id = save['id'].to_i
  end

  def update
    sql = "UPDATE tickets SET (film_id, customer_id) =
    ($1, $2) WHERE id = $3"
    values = [@film_id, @customer_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM tickets WHERE id = $1"
    SqlRunner.run(sql, [@id])
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM tickets"
    return Ticket.map_items(SqlRunner.run(sql))
  end

    def self.map_items(items)
      return items.map { |item| Ticket.new(item) }
    end

end
