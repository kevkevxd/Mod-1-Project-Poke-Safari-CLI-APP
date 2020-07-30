class AddColumnStat < ActiveRecord::Migration[6.0]
  def change
    add_column :pokemons, :stat, :integer
  end
end
