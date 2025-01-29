class CreateProductParts < ActiveRecord::Migration[7.2]
  def change
    create_table :product_parts do |t|
      t.timestamps
    end
  end
end
