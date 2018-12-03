require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

require('pry-byebug')

Film.delete_all()
Customer.delete_all()
Ticket.delete_all()

film1 = Film.new({ 'title' => 'Pulp Fiction', 'price' => 5})
film1.save()

film2 = Film.new({ 'title' => 'Goodfellas', 'price' => 5})
film2.save()

film3 = Film.new({ 'title' => '89', 'price' => 5})
film3.save()


customer1 = Customer.new({'name' => 'Mike Jones', 'funds' => 20})
customer1.save()

customer2 = Customer.new({'name' => 'Mick Jagger', 'funds' => 5})
customer2.save()


ticket1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film1.id})
ticket2.save

ticket3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
ticket3.save

ticket4 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film2.id})
ticket4.save()

ticket5 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film3.id})
ticket5.save()

ticket6 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
ticket6.save()

binding.pry
nil
