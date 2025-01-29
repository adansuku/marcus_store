class Variant < ApplicationRecord
  belongs_to :product
  has_many :variant_options, dependent: :destroy

  validates :sku, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_quantity, numericality: { greater_than_or_equal_to: 0 }
end
