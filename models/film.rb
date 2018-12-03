require_relative("../DB/sql_runner")

class Film

attr_reader :id, :title, :price

def initialize(options)
@id = options['id'].to_i if options['id']
@title = options['title']
@price = options['price']
end

def save()
  sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
  values = [@title, @price]
  user = SqlRunner.run(sql, values).first
  @id = user['id'].to_i
end

def self.all()
  sql = "SELECT * FROM fims"
  films = SqlRunner.run(sql, values)
  result = films.map{|film| Film.new(film)}
  return result
end

def update()
  sql = "UPDATE customers SET (title, price) = ($1, $2) WHERE id = $3"
  values = [@title, @price]
  SqlRunner.run(sql, values)
end

def delete()
  sql = "DELETE FROM films WHERE id = $1"
  values = [@id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

def customers()
  sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1"
  values = [@id]
  customer_array = SqlRunner.run(sql, values)
  customers = customer_array.map{|customer_hash| Customer.new(customer_hash)}
  return customers
end

def total_tickets_sold()
  sql ="SELECT * FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.film_id = $1"
  values = [@id]
  tickets_sold_array = SqlRunner.run(sql, values)
  tickets_sold_total = tickets_sold_array.map{|ticket_sold_hash|Film.new(ticket_sold_hash)}
  return tickets_sold_total.count
end





end
