class PartOption < ApplicationRecord
  belongs_to :part
  has_many :pricing_rules, foreign_key: :part_option_id, dependent: :destroy
  has_many :dependent_pricing_rules, class_name: 'PricingRule', foreign_key: :dependent_part_option_id, dependent: :destroy

  has_many :source_restrictions, class_name: 'Restriction', foreign_key: :source_part_option_id, dependent: :destroy
  has_many :target_restrictions, class_name: 'Restriction', foreign_key: :target_part_option_id, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :in_stock, inclusion: { in: [true, false] }

  def restrictions
    Restriction.where("source_part_option_id = :id OR target_part_option_id = :id", id: self.id)
  end

end
