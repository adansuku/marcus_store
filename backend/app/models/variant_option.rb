class VariantOption < ApplicationRecord
  belongs_to :variant

  validates :option_name, presence: true
  validates :option_value, presence: true
end
