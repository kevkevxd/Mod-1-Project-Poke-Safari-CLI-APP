class RemoveBaitUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :bait, :integer
  end
end
