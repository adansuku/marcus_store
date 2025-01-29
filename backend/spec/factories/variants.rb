FactoryBot.define do
  factory :variant do
    association :product, factory: :variant_based_product
    sequence(:sku) { |n| "VARIANT-#{n}" }
    price { 75.00 }
    stock_quantity { 10 }
    active { true }
  end
end
