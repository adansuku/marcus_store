class CreateRestrictions < ActiveRecord::Migration[7.1]
  def change
    create_table :restrictions do |t|
      t.references :source_part_option, null: false, foreign_key: { to_table: :part_options }
      t.references :target_part_option, null: false, foreign_key: { to_table: :part_options }
      t.string :restriction_type, null: false
      t.timestamps
    end
    add_index :restrictions, [:source_part_option_id, :target_part_option_id], unique: true, name: 'idx_restrictions_unique'
  end
end
