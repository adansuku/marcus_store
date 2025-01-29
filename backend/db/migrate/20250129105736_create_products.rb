class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.string :product_type, null: false
      t.decimal :base_price, precision: 10, scale: 2 # Base products price for single products without variants or parts
      t.boolean :active, default: true
      t.references :category, foreign_key: true, null: true

      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
