FactoryBot.define do
  factory :variant_option do
    association :variant
    option_name { "Color" }
    option_value { "Red" }
  end
end
