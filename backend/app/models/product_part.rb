class ProductPart < ApplicationRecord
  belongs_to :product
  belongs_to :part
  has_many :part_options, through: :part

  validates :part_id, uniqueness: { scope: :product_id }

  before_save :set_default_required

  private

  def set_default_required
    self.required = true if required.nil?
  end
end
