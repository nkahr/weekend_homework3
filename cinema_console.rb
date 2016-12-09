require_relative('customers.rb')
require_relative('tickets.rb')
require_relative('films.rb')
require('pry')


nina = Customer.new({"name" => "Nina", "funds" => 200})
nina.save()
film = Film.new({"title" => "Shawshank Redemption", "price" => 20})
film.save()
ticket = Ticket.new({"customer_id" => nina.id,"film_id" => film.id})
ticket.save()






binding.pry
nil

