class CreatePricingRules < ActiveRecord::Migration[7.2]
  def change
    create_table :pricing_rules do |t|
      t.references :product, foreign_key: true
      t.references :variant_option, foreign_key: true, null: true # Opción que afecta el precio en productos `variant_based`
      t.references :part_option, foreign_key: true, null: true    # Opción que afecta el precio en productos `part_based`
      t.references :dependent_variant_option, foreign_key: { to_table: :variant_options }, null: true # Dependencia para productos `variant_based`
      t.references :dependent_part_option, foreign_key: { to_table: :part_options }, null: true      # Dependencia para productos `part_based`
      t.decimal :price, precision: 10, scale: 2, default: 0.0
      t.timestamps
    end

    # Índices únicos para evitar reglas duplicadas
    add_index :pricing_rules,
              [:product_id, :variant_option_id, :dependent_variant_option_id],
              unique: true,
              name: 'idx_variant_pricing_rules_unique'

    add_index :pricing_rules,
              [:product_id, :part_option_id, :dependent_part_option_id],
              unique: true,
              name: 'idx_part_pricing_rules_unique'
  end
end
