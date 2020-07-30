class AddColumnStatSpecies < ActiveRecord::Migration[6.0]
  def change
    add_column :species, :stat, :integer
  end
end
