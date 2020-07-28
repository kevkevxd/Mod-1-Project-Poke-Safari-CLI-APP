class UpdateSpeciesWithType < ActiveRecord::Migration[6.0]
  def change
    add_column :species, :type_id, :integer
  end
end
