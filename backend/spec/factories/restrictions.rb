FactoryBot.define do
  factory :restriction do
    association :source_part_option, factory: :part_option
    association :target_part_option, factory: :part_option
    restriction_type { %w[requires excludes].sample }
  end
end
