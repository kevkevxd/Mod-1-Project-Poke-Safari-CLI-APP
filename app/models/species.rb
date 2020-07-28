class Species < ActiveRecord::Base
    has_many :pokemons
    belongs_to :type
end
