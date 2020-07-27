require 'rest-client'
require 'json'
require 'pry'

Pokemon.delete_all
Species.delete_all


species_response = RestClient.get("https://pokeapi.co/api/v2/pokemon-species/?limit=151&offset=0")
all_pokemon_species = JSON.parse(species_response)

all_pokemon_species["results"].each do |pokemon|
    Species.create(name: pokemon["name"])
end






binding.pry

