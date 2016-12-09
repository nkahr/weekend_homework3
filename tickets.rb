require_relative('db/sql_runner.rb')

class Ticket 

  attr_reader :id 
  attr_accessor :customer_id, :film_id

  def initialize(ticket_hash)
    @id = ticket_hash['id'].to_i() unless ticket_hash['id'].nil?
    @customer_id = ticket_hash['customer_id'].to_i()
    @film_id = ticket_hash['film_id'].to_i()
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES (#{@customer_id}, #{@film_id}) RETURNING *;"
    @id = SqlRunner.run(sql)[0]['id']
  end


end