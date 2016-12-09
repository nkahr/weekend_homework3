require_relative('db/sql_runner.rb')
class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(film_hash)
    @id = film_hash['id'].to_i() unless customer_hash['id'].nil?
    @title = film_hash['title']
    @price = film_hash['price']
  end


end