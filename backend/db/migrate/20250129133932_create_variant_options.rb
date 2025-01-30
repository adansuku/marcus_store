class CreateVariantOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :variant_options do |t|
      t.references :variant, null: false, foreign_key: true
      t.string :option_name, null: false
      t.string :option_value, null: false
      t.timestamps
    end
  end
end
