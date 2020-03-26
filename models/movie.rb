require_relative('../db/sql_runner.rb')

class Movie

  attr_reader :id
  attr_accessor :title, :genre, :budget

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget']
  end

  def save()
    sql = "INSERT INTO movies (title, genre, budget)
           VALUES ($1, $2, $3)
           RETURNING id"
    values = [@title, @genre, @budget]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM movies"
    movie_data = SqlRunner.run(sql)
    self.map_items(movie_data)
  end

  def stars()
    sql = "SELECT stars.*
           FROM stars
           INNER JOIN castings
           ON castings.star_id = stars.id
           WHERE castings.movie_id = $1"
    values = [@id]
    star_data = SqlRunner.run(sql, values)
    Star.map_items(star_data)
  end

  def castings()
    sql = "SELECT * FROM castings
           WHERE movie_id = $1"
    values = [@id]
    casting_data = SqlRunner.run(sql, values)
    return casting_data.map{|casting| Casting.new(casting)}
  end

  def remaining_budget()
    castings = self.castings()
    casting_fees = castings.map{|casting| casting.fee}
    combined_fees = casting_fees.sum
    return @budget - combined_fees
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM movies
           WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    movie = Movie.new(results.first())
    return movie
  end

  def self.find_by_title(title)
    sql = "SELECT * FROM movies
           WHERE title = $1"
    values = [title]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    movie = Movie.new(results.first())
    return movie
  end

  def self.find_by_genre(genre)
    sql = "SELECT * FROM movies
           WHERE genre = $1"
    values = [genre]
    results = SqlRunner.run(sql, values)
    return nil if results.first() == nil
    movie = Movie.new(results.first())
    return movie
  end

  def update()
    sql = "UPDATE movies SET (title, genre, budget)
           = ($1, $2, $3)
           WHERE id = $4"
    values =[@title, @genre, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM movies
           WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end

  def self.map_items(movie_data)
    result = movie_data.map { |movie| Movie.new( movie ) }
    return result
  end

end
