class Product < ApplicationRecord
  belongs_to :category
  has_many :variants, dependent: :destroy
  has_many :product_parts, dependent: :destroy
  has_many :parts, through: :product_parts

  enum product_type: { single: "single", variant_based: "variant_based", part_based: "part_based" }
  validates :product_type, presence: true, inclusion: { in: product_types.keys }
  validates :name, presence: true, uniqueness: true
  validate :validate_product_type_associations

  private

  def validate_product_type_associations
    if variant_based? && product_parts.exists?
      errors.add(:base, 'A variant-based product cannot have parts')
    elsif part_based? && variants.exists?
      errors.add(:base, 'A part-based product cannot have variants')
    end
  end

  def valid_product_type?(product_type)
    product_types.keys.include?(product_type)
  end
end
