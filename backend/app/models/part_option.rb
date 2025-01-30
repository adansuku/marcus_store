class PartOption < ApplicationRecord
  belongs_to :part
  has_many :source_restrictions, class_name: 'Restriction', foreign_key: :source_part_option_id, dependent: :destroy
  has_many :target_restrictions, class_name: 'Restriction', foreign_key: :target_part_option_id, dependent: :destroy

  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :in_stock, inclusion: { in: [true, false] }

end
