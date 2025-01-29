class Part < ApplicationRecord
  has_many :product_parts, dependent: :destroy
  has_many :products, through: :product_parts
  has_many :part_options, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
