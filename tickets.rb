require_relative('db/sql_runner.rb')

class Ticket 

  attr_reader :id 
  attr_accessor :customer_id, :film_id, :time

  def initialize(ticket_hash)
    @id = ticket_hash['id'].to_i() unless ticket_hash['id'].nil?
    @customer_id = ticket_hash['customer_id'].to_i()
    @film_id = ticket_hash['film_id'].to_i()
    @time = ticket_hash['time']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id, time) VALUES (#{@customer_id}, #{@film_id}, '#{time}') RETURNING *;"
    @id = SqlRunner.run(sql)[0]['id']
  end

  def get()
    sql = "SELECT * FROM tickets WHERE id = #{@id};"
    return Ticket.new(SqlRunner.run(sql)[0])
  end

  def self.get_all()
    sql = "SELECT * FROM tickets;"
    return Ticket.get_many(sql)
  end

  def delete()
    sql = "DELETE FROM tickets where id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE tickets WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.get_many(sql)
    result = SqlRunner.run(sql)
    return result.map{|ticket| Ticket.new(ticket)}
  end

end