require_relative('../db/sql_runner.rb')
require_relative('screening')

class Film

attr_reader :id
attr_accessor :title, :price

def initialize( options )
  @id = options['id'].to_i if options['id']
  @title = options ['title']
  @price = options ['price'].to_i
end

def save()
  sql = "INSERT INTO films
  (title, price)
  VALUES
  ($1, $2)
  RETURNING id"
  values = [@title, @price]
  film = SqlRunner.run( sql, values ).first
  @id = film['id'].to_i
end

def update()
  sql = "UPDATE films SET
  (title, price)
  =
  ($1, $2)
  WHERE id = $3"
  values = [@title, @price, @id]
  SqlRunner.run(sql, values)
end

def self.delete_all()
 sql = "DELETE FROM films"
 SqlRunner.run(sql)
end

def delete()
 sql = "DELETE FROM films WHERE id = $1"
 values = [@id]
 SqlRunner.run(sql, values)
end

def self.all()
  sql = "SELECT * FROM films"
  film_hashes = SqlRunner.run(sql)
  films = film_hashes.map { |film| Film.new( film ) }
  return films
end


# ***   why does this return 6 lines when called - film1.film_screening_time -- ?/
def film_screening_time()
  sql = "SELECT screenings.film_time FROM screenings
  INNER JOIN films
  ON screenings.film_id = $1"
  values = [@id]
  time_hashes = SqlRunner.run(sql, values)
  return time_hashes.map{|time| Screening.new(time)}
end



end
