class CreatePartOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :part_options do |t|
      t.references :part, null: false, foreign_key: true
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, default: 0.0
      t.boolean :in_stock, default: true
      t.timestamps
    end

    add_index :part_options, [:part_id, :name], unique: true
  end
end
