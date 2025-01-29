FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" } # Esto evita colisiones de nombres
    description { "A high-quality product" }
    base_price { 0 }
    active { true }
    association :category

    trait :variant_based_without_parts do
      product_type { "part_based" }
    end

    trait :part_based_without_parts do
      product_type { "part_based" }
    end

    trait :variant_based do
      product_type { "variant_based" }

      after(:create) do |product|
        create_list(:variant, 2, product: product)
      end
    end

    trait :part_based do
      product_type { "part_based" }
    end

    factory :variant_based_product, traits: [:variant_based]
    factory :part_based_product, traits: [:part_based]

    factory :no_parts_product, traits: [:part_based_without_parts]
    factory :no_variant_product, traits: [:variant_based_without_parts]

  end
end
