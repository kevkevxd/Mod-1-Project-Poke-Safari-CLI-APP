class RemoveStatPokemons < ActiveRecord::Migration[6.0]
  def change
    remove_column :pokemons, :stat, :integer
  end
end
