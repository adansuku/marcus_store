class PricingRule < ApplicationRecord
  belongs_to :part_option
  belongs_to :dependent_part_option, class_name: 'PartOption'

  validates :price, numericality: { greater_than_or_equal_to: 0 }

  validate :different_part_options

  private

  def different_part_options
    if part_option_id == dependent_part_option_id
      errors.add(:base, 'Part option and dependent part option must be different')
    end
  end
end
