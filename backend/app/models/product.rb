class Product < ApplicationRecord
  belongs_to :category

  validates :name, presence: true, uniqueness: true
  validates :product_type, inclusion: { in: %w[variant_based part_based] }

end
