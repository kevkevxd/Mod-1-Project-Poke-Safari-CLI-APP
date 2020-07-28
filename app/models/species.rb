class Species < ActiveRecord::Base
    has_many :pokemons
    has_many :types
end
