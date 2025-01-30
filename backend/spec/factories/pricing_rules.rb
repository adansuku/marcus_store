FactoryBot.define do
  factory :pricing_rule do
    association :part_option
    association :dependent_part_option, factory: :part_option
    price { 30.00 }
  end
end
