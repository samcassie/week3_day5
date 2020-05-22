require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

require('pry')

Screening.delete_all()
Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

################### FILMS

film1 = Film.new({
    'title' => 'Batman',
    'price' => 20
})

film1.save()

film2 = Film.new({
    'title' => 'Pokemon',
    'price' => 30
})

film2.save()

################### CUSTOMERS

customer1 = Customer.new({
    'name' => 'Sam',
    'funds' => 40
})

customer1.save()

customer2 = Customer.new({
    'name' => 'Robb',
    'funds' => 100
})

customer2.save()

################### TICKETS

ticket1 = Ticket.new({
    'customer_id' => customer2.id,
    'film_id' => film1.id
})

ticket1.save()

ticket2 = Ticket.new({
    'customer_id' => customer1.id,
    'film_id' => film2.id
})

ticket2.save()

ticket3 = Ticket.new({
    'customer_id' => customer1.id,
    'film_id' => film1.id
})

ticket3.save()

################### SCREENINGS

screening1 = Screening.new({
    'film_id' => film1.id,
    'tickets_sold' => 10,
    'start_time' => '20:00'
})

screening1.save()

screening2 = Screening.new({
    'film_id' => film1.id,
    'tickets_sold' => 15,
    'start_time' => '21:00'
})

screening2.save()

screening3 = Screening.new({
    'film_id' => film2.id,
    'tickets_sold' => 12,
    'start_time' => '16:30'
})

screening3.save()

binding.pry()
nil
