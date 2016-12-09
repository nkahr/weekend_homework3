require_relative('db/sql_runner.rb')
require_relative('films.rb')
require_relative('tickets.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds, :ticket_count

  def initialize(customer_hash)
    @id = customer_hash['id'].to_i() unless customer_hash['id'].nil?
    @name = customer_hash['name']
    @funds = customer_hash['funds']
    @ticket_count = 0
  end

  def buy_ticket(film)
    ticket = Ticket.new("customer_id" => @id, "film_id" => film.id())
    ticket.save()
    @funds -= film.price()
    @ticket_count += 1
    film.customer_count += 1
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', #{@funds}) RETURNING *;"
    @id = SqlRunner.run(sql)[0]['id']
  end

  def self.get_all()
    sql = "SELECT * FROM customers"
    return Customer.get_many(sql)
  end

  def get()
    sql = "SELECT * FROM customers WHERE id = #{@id};"
    return Customer.new(SqlRunner.run(sql)[0])
  end

  def delete()
    sql = "DELETE FROM customers where id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE customers WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def get_films()
    sql ="
    SELECT f.*, t.* FROM films f 
    INNER JOIN tickets t 
    ON t.film_id = f.id
    WHERE t.customer_id = #{@id};"
    return Film.get_many(sql)
  end 

  def self.get_many(sql)
    result = SqlRunner.run(sql)
    return result.map{|customer| Customer.new(customer)}
  end

end

