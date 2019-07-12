require_relative('../db/sql_runner.rb')

class Customer

attr_reader :id
attr_accessor :name, :funds

def initialize( options )
  @id = options['id'].to_i if options['id']
  @name = options ['name']
  @funds = options ['funds'].to_i
end

def buy_ticket(film)
  sql = "UPDATE customers SET
  funds = $1 WHERE id = $2"
  new_funds = @funds - film.price
  values = [new_funds, @id]
  SqlRunner.run(sql, values)
end

# def num_of_tickets()
#   sql = "SELECT COUNT(DISTINCT customer_id) FROM tickets
#   WHERE $1"
#   values = [@id]
#   SqlRunner.run(sql, values)
#   # return Customer.new(tickets)
# end


def update()
  sql = "UPDATE customers SET
  (name, funds)
  =
  ($1, $2)
  WHERE id = $3"
  values = [@name, @funds, @id]
  SqlRunner.run(sql, values)
end


#returns all films linked to customer when run => customer.films
def films
  sql = "SELECT films.* FROM films
  INNER JOIN tickets
  ON tickets.film_id = films.id
  WHERE tickets.customer_id = $1"
  values = [@id]
  films = SqlRunner.run(sql, values)
  return films.map{|film| Film.new(film)}
end

def save()
  sql = "INSERT INTO customers
  (name, funds)
  VALUES
  ($1, $2)
  RETURNING id"
  values = [@name, @funds]
  customer = SqlRunner.run( sql, values ).first
  @id = customer['id'].to_i
end


def self.delete_all()
 sql = "DELETE FROM customers"
 SqlRunner.run(sql)
end

def delete()
 sql = "DELETE FROM customers WHERE id = $1"
 values = [@id]
 SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM customers"
  customer_hashes = SqlRunner.run(sql)
  customers = customer_hashes.map { |customer| Customer.new( customer ) }
  return customers
end


end
