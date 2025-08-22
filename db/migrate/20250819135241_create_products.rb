# db/migrate/xxx_create_products.rb
class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 8, scale: 2, null: false
      t.string :category, null: false
      t.integer :stock_quantity, default: 0
      t.boolean :featured, default: false

      t.timestamps
    end
    
    add_index :products, :category
    add_index :products, :featured
  end
end