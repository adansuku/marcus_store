# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_01_30_111900) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "parent_category_id"
    t.integer "position"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
  end

  create_table "part_options", force: :cascade do |t|
    t.bigint "part_id", null: false
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, default: "0.0"
    t.boolean "in_stock", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_id", "name"], name: "index_part_options_on_part_id_and_name", unique: true
    t.index ["part_id"], name: "index_part_options_on_part_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_parts_on_name", unique: true
  end

  create_table "pricing_rules", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "variant_option_id"
    t.bigint "part_option_id"
    t.bigint "dependent_variant_option_id"
    t.bigint "dependent_part_option_id"
    t.decimal "price", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dependent_part_option_id"], name: "index_pricing_rules_on_dependent_part_option_id"
    t.index ["dependent_variant_option_id"], name: "index_pricing_rules_on_dependent_variant_option_id"
    t.index ["part_option_id"], name: "index_pricing_rules_on_part_option_id"
    t.index ["product_id", "part_option_id", "dependent_part_option_id"], name: "idx_part_pricing_rules_unique", unique: true
    t.index ["product_id", "variant_option_id", "dependent_variant_option_id"], name: "idx_variant_pricing_rules_unique", unique: true
    t.index ["product_id"], name: "index_pricing_rules_on_product_id"
    t.index ["variant_option_id"], name: "index_pricing_rules_on_variant_option_id"
  end

  create_table "product_parts", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "part_id", null: false
    t.boolean "required", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_id"], name: "index_product_parts_on_part_id"
    t.index ["product_id", "part_id"], name: "index_product_parts_on_product_id_and_part_id", unique: true
    t.index ["product_id"], name: "index_product_parts_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "product_type", null: false
    t.decimal "base_price", precision: 10, scale: 2
    t.boolean "active", default: true
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["name"], name: "index_products_on_name", unique: true
  end

  create_table "restrictions", force: :cascade do |t|
    t.bigint "source_part_option_id", null: false
    t.bigint "target_part_option_id", null: false
    t.string "restriction_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_part_option_id", "target_part_option_id"], name: "idx_restrictions_unique", unique: true
    t.index ["source_part_option_id"], name: "index_restrictions_on_source_part_option_id"
    t.index ["target_part_option_id"], name: "index_restrictions_on_target_part_option_id"
  end

  create_table "variant_options", force: :cascade do |t|
    t.bigint "variant_id", null: false
    t.string "option_name", null: false
    t.string "option_value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["variant_id"], name: "index_variant_options_on_variant_id"
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "sku", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.integer "stock_quantity", default: 0, null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_variants_on_product_id"
    t.index ["sku"], name: "index_variants_on_sku", unique: true
  end

  add_foreign_key "categories", "categories", column: "parent_category_id"
  add_foreign_key "part_options", "parts"
  add_foreign_key "pricing_rules", "part_options"
  add_foreign_key "pricing_rules", "part_options", column: "dependent_part_option_id"
  add_foreign_key "pricing_rules", "products"
  add_foreign_key "pricing_rules", "variant_options"
  add_foreign_key "pricing_rules", "variant_options", column: "dependent_variant_option_id"
  add_foreign_key "product_parts", "parts"
  add_foreign_key "product_parts", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "restrictions", "part_options", column: "source_part_option_id"
  add_foreign_key "restrictions", "part_options", column: "target_part_option_id"
  add_foreign_key "variant_options", "variants"
  add_foreign_key "variants", "products"
end
