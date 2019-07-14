require_relative('../db/sql_runner.rb')
require_relative('film')
require_relative('customer')
require_relative('screening')

class Ticket

attr_reader :id
attr_accessor :customer_id, :screening_id

def initialize( options )
  @id = options['id'].to_i if options['id']
  @customer_id = options ['customer_id'].to_i
  @screening_id = options ['screening_id'].to_i
end


def film()
  sql = "SELECT * FROM tickets
  WHERE id = $1"
  values = [@screening_id]
  film = SqlRunner.run(sql, values).first
  return Film.new(film)
end

def customer()
  sql = "SELECT * FROM customers
  WHERE id = $1"
  values = [@customer_id]
  customer = SqlRunner.run(sql, values).first
  return Customer.new(star)
end

def save()
  sql = "INSERT INTO tickets
  (customer_id, screening_id)
  VALUES
  ($1, $2)
  RETURNING id"
  values = [@customer_id, @screening_id]
  ticket = SqlRunner.run( sql, values ).first
  @id = ticket['id'].to_i
end

def update()
  sql = "UPDATE tickets SET
  (customer_id, screening_id)
  =
  ($1, $2)
  WHERE id = $3"
  values = [@customer_id, @screening_id, @id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
 sql = "DELETE FROM tickets"
 SqlRunner.run(sql)
end

def delete()
 sql = "DELETE FROM tickets WHERE id = $1"
 values = [@id]
 SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM tickets"
  ticket_hashes = SqlRunner.run(sql)
  tickets = ticket_hashes.map { |ticket| Ticket.new( ticket ) }
  return tickets
end

#MOST POPULAR SCREEN TIME
#*** when we return a hash of results from the database, and before it is passed into the class, what does it look like? How is it processed by the iteration? *last line below.
def self.most_popular_screening()
  sql = "SELECT screenings.* FROM screenings
  INNER JOIN tickets
  ON screenings.id = tickets.screening_id"
  screening_hash = SqlRunner.run(sql)
  array = screening_hash.map{|screen_time| Screening.new(screen_time)}
  p array

  # array.group_by { |_,v| v }.max_by{|_,v| v.size}.first
  # array.max_by { |i| array.count(i) }

  # most_frequent_item = array.uniq.max_by{ | i | array.count( i ) }
  # puts most_frequent_item
end


def self.most_popular_screening2()
array = self.all
# array.group_by { |_,v| v }.max_by{|_,v| v.size}.first
# array.max_by { |i| array.count(i) }
end

# h = Hash["a","foo", "b","bar", "c","foo"]
# h.group_by { |_,v| v }.max_by{|_,v| v.size}.first
# # >> "foo"


end
