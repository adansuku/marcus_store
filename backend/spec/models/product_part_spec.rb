require 'rails_helper'

RSpec.describe ProductPart, type: :model do
  describe 'validations' do
    let(:product) { create(:product, :part_based) }
    let(:part) { create(:part) }

    it 'is valid with valid attributes' do
      product_part = build(:product_part, product: product, part: part)
      expect(product_part).to be_valid
    end

    it 'is invalid if the same part is added to the same product more than once' do
      create(:product_part, product: product, part: part)
      duplicate_product_part = build(:product_part, product: product, part: part)

      expect(duplicate_product_part).not_to be_valid
      expect(duplicate_product_part.errors[:part_id]).to include('has already been taken')
    end
  end

  describe '#required' do
    it 'defaults to true if not explicitly set' do
      product = create(:product, :part_based)
      part = create(:part)
      product_part = build(:product_part, product:, part:, required: nil)
      product_part.save
      expect(product_part.reload.required).to be true
    end
  end
end
