class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.references :parent_category, foreign_key: { to_table: :categories }, null: true
      t.integer :position
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
