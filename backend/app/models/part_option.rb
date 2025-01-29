class PartOption < ApplicationRecord
  belongs_to :part

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :in_stock, inclusion: { in: [true, false] }
end
