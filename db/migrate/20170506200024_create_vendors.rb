class CreateVendors < ActiveRecord::Migration[5.1][5.0]
  def change
    create_table :vendors do |t|
      t.string :name
      t.integer :category

      t.timestamps
    end
  end
end
