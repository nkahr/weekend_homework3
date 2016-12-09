require_relative('db/sql_runner.rb')
class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(customer_hash)
    @id = customer_hash['id'].to_i() unless customer_hash['id'].nil?
    @name = customer_hash['name']
    @funds = customer_hash['funds']
  end



end