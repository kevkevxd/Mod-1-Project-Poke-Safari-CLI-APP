class CreateTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :types do |t|
      t.string :type_one
      t.string :type_two
    end
  end
end
