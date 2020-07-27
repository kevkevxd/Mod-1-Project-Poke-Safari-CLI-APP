require_relative '../config/environment'
require 'poke-api-v2'
require 'pry'
bulbasaur = PokeApi.get(pokemon: 'bulbasaur')

puts "HELLO WORLD"

binding.pry