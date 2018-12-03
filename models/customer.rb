require_relative("../DB/sql_runner.rb")

class Customer

  attr_reader :id, :name
  attr_accessor :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    user = SqlRunner.run(sql, values).first
    @id = user['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql, values)
    result = customers.map{|customer| Customer.new(customer)}
    return result
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE tickets.customer_id = $1"
    values = [@id]
    film_array = SqlRunner.run(sql, values)
    films = film_array.map{|film_hash| Film.new(film_hash)}
    return films
  end

  def customer_buys_ticket(price)
    @funds -= price
    sql = "UPDATE customers SET funds = $1"
    values = [@funds]
    SqlRunner.run(sql, values)
  end

  # def up_date_customer_cash()
  #   customer_buys_ticket(5)
  #   sql = "UPDATE customers SET funds = $1 WHERE id = $2"
  #   values = [@funds]
  #   SqlRunner.run(sql, values)
  # end


  def total_tickets_brought()
    sql ="SELECT * FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE customer_id = $1"
    values = [@id]
    tickets_array = SqlRunner.run(sql, values)
    tickets_total = tickets_array.map{|ticket_hash|Customer.new(ticket_hash)}
    return tickets_total.count()
  end



end
