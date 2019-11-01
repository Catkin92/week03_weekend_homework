require_relative('./models/film.rb')
require_relative('./models/customer.rb')
require_relative('./models/ticket.rb')
require('pry')

Film.delete_all

film1 = Film.new('title' => 'Batman and Robin', 'price' => 4.00)
film2 = Film.new('title' => 'Batman Forever', 'price' => 4.50)
film3 = Film.new('title' => 'Batman', 'price' => 4.50)
film4 = Film.new('title' => 'The Dark Knight', 'price' => 5.00)

film1.save
film2.save
film3.save
film4.save

customer1 = Customer.new('name' => 'Sandy', 'funds' => 20.00)
customer2 = Customer.new('name' => 'John', 'funds' => 5.00)
customer3 = Customer.new('name' => 'Eugene', 'funds' => 13.00)
customer4 = Customer.new('name' => 'Juan', 'funds' => 9.00)

customer1.save
customer2.save
customer3.save
customer4.save

ticket1 = Ticket.new('film_id' => film1.id, 'customer_id' => customer1.id)
ticket2 = Ticket.new('film_id' => film2.id, 'customer_id' => customer4.id)
ticket3 = Ticket.new('film_id' => film3.id, 'customer_id' => customer3.id)
ticket4 = Ticket.new('film_id' => film3.id, 'customer_id' => customer2.id)
ticket5 = Ticket.new('film_id' => film4.id, 'customer_id' => customer1.id)
ticket6 = Ticket.new('film_id' => film1.id, 'customer_id' => customer3.id)

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save
ticket6.save

binding.pry

nil
