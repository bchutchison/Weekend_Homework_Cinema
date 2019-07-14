require_relative('../db/sql_runner.rb')
require_relative('film')

class Screening

attr_reader :id
attr_accessor :film_time, :film_id

def initialize( options )
  @id = options['id'].to_i if options['id']
  @film_time = options ['film_time']
  @film_id = options ['film_id'].to_i
end

def save()
  sql = "INSERT INTO screenings
  (film_time, film_id)
  VALUES
  ($1, $2)
  RETURNING id"
  values = [@film_time, @film_id]
  screening = SqlRunner.run( sql, values ).first
  @id = screening['id'].to_i
end

def update()
  sql = "UPDATE screenings SET
  (film_time, film_id)
  =
  ($1, $2)
  WHERE id = $3"
  values = [@film_time, @film_id, @id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
 sql = "DELETE FROM screenings"
 SqlRunner.run(sql)
end

def delete()
 sql = "DELETE FROM screenings WHERE id = $1"
 values = [@id]
 SqlRunner.run(sql, values)
end

#Returns all screenings. ***error message -
# [8] pry(main)> Screening.all
# NameError: undefined local variable or method `screening_hash' for Screening:Class
# Did you mean?  sreening_hash
#                screenings
# from /Users/benhutchison/codeclan_work/week_03/day_5/weekend_homework/models/screening.rb:51:in `all'
def self.all()
  sql = "SELECT * FROM screenings"
  hash = SqlRunner.run(sql)
  screenings = hash.map { |screen| Screening.new(screen) }
  return screenings
end



#moved from film.rb following refactoring. Returns all of the customers who are going to a specified screening. ***   How does this reference the film when i call screening1.customers?   ***
def customers()
  sql = "SELECT customers.* FROM customers
  INNER JOIN tickets
  ON tickets.customer_id = customers.id
  WHERE tickets.screening_id = $1"
  values = [@id]
  customers = SqlRunner.run(sql, values)
  return customers.map{|customer| Customer.new(customer)}
end


#returns the number of customers going to a certain film. Calls .size on the array which is output from the def customers() method. Moved from film.rb
def num_of_customers()
  customers.size
end


# def most_popular_screening()
#   sql = "SELECT * FROM screening
#   WHERE"
# end






end
