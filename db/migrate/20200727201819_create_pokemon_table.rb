class CreatePokemonTable < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :nickname
      t.integer :user_id
      t.integer :species_id
      t.string :type
    end
  end
end
