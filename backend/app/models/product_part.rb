class ProductPart < ApplicationRecord
  belongs_to :product
  belongs_to :part
  has_many :part_options, through: :part

  validates :part_id, uniqueness: { scope: :product_id }
end
