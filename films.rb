require_relative('db/sql_runner.rb')
class Film

  attr_reader :id
  attr_accessor :title, :price, :customer_count, :ticket_limit

  def initialize(film_hash)
    @id = film_hash['id'].to_i() unless film_hash['id'].nil?
    @title = film_hash['title']
    @price = film_hash['price']
    @customer_count = 0
    @ticket_limit = film_hash['ticket_limit']
  end

  def most_popular_time()
    sql = "
      SELECT time
      FROM tickets
      GROUP BY time
      ORDER BY COUNT(*) DESC
      LIMIT 1;"
      return SqlRunner.run(sql)[0]['time']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{@price}) RETURNING *;"
    @id = SqlRunner.run(sql)[0]['id']
  end

  def self.get_all()
    sql = "SELECT * FROM films;"
    return Film.get_many(sql)
  end

  def get()
    sql = "SELECT * FROM films WHERE id = #{@id};"
    return Film.new(SqlRunner.run(sql)[0])
  end

  def delete()
    sql = "DELETE FROM films where id = #{@id};"
    SqlRunner.run(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def get_customers()
    sql ="
    SELECT c.* FROM customers c
    INNER JOIN tickets t 
    ON t.customer_id = c.id
    WHERE t.film_id = #{@id};"
    return Customer.get_many(sql)
  end 

  def self.get_many(sql)
    result = SqlRunner.run(sql)
    return result.map{|film| Film.new(film)}
  end

end