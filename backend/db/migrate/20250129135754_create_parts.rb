class CreateParts < ActiveRecord::Migration[7.2]
  def change
    create_table :parts do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps
    end

    add_index :parts, :name, unique: true
  end
end
