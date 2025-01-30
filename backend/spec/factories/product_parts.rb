FactoryBot.define do
  factory :product_part do
    association :product
    association :part
    required { true }
  end
end
