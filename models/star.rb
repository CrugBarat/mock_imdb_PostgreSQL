require_relative('../db/sql_runner.rb')

class Star

  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
  end

  def save()
    sql = "INSERT INTO stars (first_name, last_name)
           VALUES ($1, $2)
           RETURNING *"
    values = [@first_name, @last_name]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM stars"
    star_data = SqlRunner.run(sql)
    self.map_items(star_data)
  end

  def movies()
    sql = "SELECT movies.*
           FROM movies
           INNER JOIN castings
           ON castings.movie_id = movies.id
           WHERE castings.star_id = $1"
    values = [@id]
    movie_data = SqlRunner.run(sql, values)
    Movie.map_items(movie_data)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM stars
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    return Star.new(results.first())
  end

  def update()
    sql = "UPDATE stars SET (first_name, last_name)
           = ($1, $2)
           WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM stars"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM stars
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(star_data)
    return star_data.map{|star| Star.new(star)}
  end

end
