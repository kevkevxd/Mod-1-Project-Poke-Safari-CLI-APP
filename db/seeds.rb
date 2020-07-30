require 'rest-client'
require 'json'
require 'pry'

Pokemon.delete_all
Species.delete_all
User.delete_all
Type.delete_all

# species_response = RestClient.get("https://pokeapi.co/api/v2/pokemon-species/?limit=151&offset=0")
# all_pokemon_species = JSON.parse(species_response)

# all_pokemon_species["results"].each do |pokemon|
#     Species.create(name: pokemon["name"])
# end
#add_column :types, :type, array: true, default: []
pokemon_response = RestClient.get("https://pokeapi.co/api/v2/pokemon/?limit=151&offset=0")
all_pokemon = JSON.parse(pokemon_response)

all_pokemon["results"].each do |pokemon|
    
    stats_response = RestClient.get(pokemon["url"])
    pokemon_stats = JSON.parse(stats_response)

    pokemon_types = pokemon_stats["types"]

    type_names = pokemon_types.map do |types| 
       types["type"]["name"]  
    end

    species_stat = pokemon_stats["stats"][0]["base_stat"] + pokemon_stats["stats"][1]["base_stat"] + pokemon_stats["stats"][2]["base_stat"] + pokemon_stats["stats"][3]["base_stat"] + pokemon_stats["stats"][4]["base_stat"] + pokemon_stats["stats"][5]["base_stat"]
    
   the_type = Type.find_or_create_by(type_one: type_names[0], type_two: type_names[1])
   Species.create(name: pokemon["name"], type_id: the_type.id, stat: species_stat)

   #¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥¥

end

#Making an easter egg for Groudon because Groudon is the mascot of Ruby

groudon_type = Type.create(type_one: "Ground", type_two: "Fire")

Species.create(name: "groudon", type_id: groudon_type.id, stat: 1000)



#pry.Start




