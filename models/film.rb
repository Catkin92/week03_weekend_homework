require_relative('../db/sql_runner.rb')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save
    sql = "INSERT INTO films(title, price)
    VALUES ($1, $2)
    RETURNING id;"
    values = [@title, @price]
    save = SqlRunner.run(sql, values)[0]
    @id = save['id'].to_i

  end

  def update
    sql = "UPDATE films SET (title, price) = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def customers_by_film
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customer_id = customers.id
    WHERE tickets.film_id = $1"
    Customer.map_items(SqlRunner.run(sql, [@id]))
  end

  def audience_size
    return self.customers_by_film.count
  end
  def delete
    sql = "DELETE FROM films WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return Film.map_items(films)
  end

  def self.map_items(items)
    return items.map { |item| Film.new(item) }
  end

end
