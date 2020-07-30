class AddColumnCurrency < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :currency, :integer
  end
end
