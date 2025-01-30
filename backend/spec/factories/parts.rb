FactoryBot.define do
  factory :part do
    sequence(:name) { |n| "Part #{n}" }
    description { "A bike part" }
  end
end
