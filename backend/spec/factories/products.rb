FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" } # Esto evita colisiones de nombres
    description { "A high-quality product" }
    base_price { 0 }
    active { true }
    association :category

    trait :variant_based do
      product_type { "variant_based" }

      after(:create) do |product|
        create_list(:variant, 2, product: product)
      end
    end

    trait :variant_based_without_parts do
      product_type { "part_based" }
    end

    trait :part_based_without_parts do
      product_type { "part_based" }
    end

    trait :part_based do
      product_type { "part_based" }

      after(:create) do |product|
        frame = create(:part, name: "Frame #{product.id}")  # Hacer únicos los nombres
        wheels = create(:part, name: "Wheels #{product.id}") # Añadir ID para evitar duplicados

        create(:product_part, product: product, part: frame, required: true)
        create(:product_part, product: product, part: wheels, required: true)

        create(:part_option, part: frame, name: "Full-Suspension #{product.id}", price: 150, in_stock: true)
        create(:part_option, part: wheels, name: "Mountain Wheels #{product.id}", price: 80, in_stock: true)
      end
    end

    factory :variant_based_product, traits: [:variant_based]
    factory :part_based_product, traits: [:part_based]

    factory :no_parts_product, traits: [:part_based_without_parts]
    factory :no_variant_product, traits: [:variant_based_without_parts]

  end
end
