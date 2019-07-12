require_relative('../db/sql_runner.rb')

class Screening

attr_reader :id
attr_accessor :time

def initialize( options )
  @id = options['id'].to_i if options['id']
  @time = options ['time'].to_i
end




end
