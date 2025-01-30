class Product < ApplicationRecord
  belongs_to :category
  has_many :variants, dependent: :destroy
  has_many :product_parts, dependent: :destroy
  has_many :parts, through: :product_parts

  validates :name, presence: true, uniqueness: true
  validates :product_type, inclusion: { in: %w[single variant_based part_based] }

  validate :validate_product_type_associations

  private

  def validate_product_type_associations
    if product_type == 'variant_based' && product_parts.exists?
      errors.add(:base, 'A variant-based product cannot have parts')
    elsif product_type == 'part_based' && variants.exists?
      errors.add(:base, 'A part-based product cannot have variants')
    end
  end
end
