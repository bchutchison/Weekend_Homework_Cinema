require_relative('models/film')
require_relative('models/customer')
require_relative('models/ticket')
require_relative('models/screening')
require('pry-byebug')

Screening.delete_all()
Ticket.delete_all()
Film.delete_all()
Customer.delete_all()


film1 = Film.new({
'title' => 'Die Hard',
'price' => 5
  })
film1.save()

film2 = Film.new({
'title' => 'Die Hard 2',
'price' => 10
  })
film2.save()

film3 = Film.new({
'title' => 'Die Hard with a vengeance',
'price' => 15
  })
film3.save()


customer1 = Customer.new({
'name' => 'Bob',
'funds' => 50
  })
customer1.save()

customer2 = Customer.new({
'name' => 'Sue',
'funds' => 20
  })
customer2.save()

customer3 = Customer.new({
'name' => 'Pete',
'funds' => 5
  })
customer3.save()

screening1 = Screening.new({
'film_time' => '18:00',
'film_id' => film3.id
  })
screening1.save()


ticket1 = Ticket.new({
'customer_id' => customer1.id,
'screening_id' => screening1.id
  })
ticket1.save()

ticket2 = Ticket.new({
'customer_id' => customer2.id,
'screening_id' => screening1.id
  })
ticket2.save()

ticket3 = Ticket.new({
'customer_id' => customer3.id,
'screening_id' => screening1.id
  })
ticket3.save()

ticket4 = Ticket.new({
'customer_id' => customer1.id,
'screening_id' => screening1.id
  })
ticket4.save()

ticket5 = Ticket.new({
'customer_id' => customer1.id,
'screening_id' => screening1.id
  })
ticket5.save()






binding.pry
nil
