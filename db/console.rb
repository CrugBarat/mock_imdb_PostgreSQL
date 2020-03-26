require('pry-byebug')
require_relative('../models/star.rb')
require_relative('../models/movie.rb')
require_relative('../models/castings.rb')

Casting.delete_all()
Movie.delete_all()
Star.delete_all()

star1 = Star.new({ 'first_name' => 'Tom',
                   'last_name' => 'Cruise'})

star2 = Star.new({ 'first_name' => 'Leonardo',
                   'last_name' => 'DiCaprio'})

star3 = Star.new({ 'first_name' => 'Scarlett',
                   'last_name' => 'Johansson'})

star1.save()
star2.save()
star3.save()


movie1 = Movie.new({ 'title' => 'Mission Impossible',
                      'genre' => 'Action',
                      'budget' => 5_000_000})

movie2 = Movie.new({ 'title' => 'Gangs of New York',
                      'genre' => 'Drama',
                      'budget' => 5_000_000})

movie3 = Movie.new({ 'title' => 'Lucy',
                      'genre' => 'Sci-Fi',
                      'budget' => 5_000_000})

movie4 = Movie.new({ 'title' => 'X-men',
                      'genre' => 'Sci-Fi',
                      'budget' => 5_000_000})

movie1.save()
movie2.save()
movie3.save()
movie4.save()


castings1 = Casting.new({ 'star_id' => star1.id,
                          'movie_id' => movie1.id,
                          'fee' => 1_000_000})

castings2 = Casting.new({ 'star_id' => star2.id,
                          'movie_id' => movie2.id,
                          'fee' => 500_000})

castings3 = Casting.new({ 'star_id' => star3.id,
                          'movie_id' => movie3.id,
                          'fee' => 1_500_000})

castings4 = Casting.new({ 'star_id' => star3.id,
                          'movie_id' => movie4.id,
                          'fee' => 2_000_000})

castings1.save()
castings2.save()
castings3.save()
castings4.save()


binding.pry
nil
