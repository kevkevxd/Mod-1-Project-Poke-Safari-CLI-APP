class DroppingTypesForNow < ActiveRecord::Migration[6.0]
  def change
    remove_column :pokemons, :type
  end
end
