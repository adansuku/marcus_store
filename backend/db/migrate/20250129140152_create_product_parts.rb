class CreateProductParts < ActiveRecord::Migration[7.2]
  def change
    create_table :product_parts do |t|
      t.references :product, null: false, foreign_key: true
      t.references :part, null: false, foreign_key: true
      t.boolean :required, default: true
      t.timestamps
    end
    add_index :product_parts, [:product_id, :part_id], unique: true
  end
end
