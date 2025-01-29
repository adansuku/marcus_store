FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    description { "A general category" }
    active { true }

    trait :with_parent do
      association :parent_category, factory: :category
    end
  end
end
