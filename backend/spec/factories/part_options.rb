FactoryBot.define do
  factory :part_option do
    sequence(:name) { |n| "Part Option #{n}" }
    price { 10.0 }
    in_stock { true }
    association :part
  end
end
