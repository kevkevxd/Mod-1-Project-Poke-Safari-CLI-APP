class AddColumnBalls < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :balls, :integer
  end
end
