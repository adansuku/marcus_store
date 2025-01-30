require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'custom validations' do
    context 'when product is variant_based' do
      let(:variant_product) { create(:product, product_type: "variant_based") }

      it 'is valid with variants' do
        expect(variant_product).to be_valid
      end

      it 'is invalid if associated with parts' do
        part = create(:part)
        variant_product.parts << part

        expect(variant_product.valid?).to be false
        expect(variant_product.errors[:base]).to include('A variant-based product cannot have parts')
      end
    end

    context 'when product is part_based' do
      let(:part_product) { create(:part_based_product) }

      it 'is valid with parts' do
        expect(part_product).to be_valid
      end

      it 'is invalid if associated with variants' do
        create(:variant, product: part_product)

        expect(part_product).not_to be_valid
        expect(part_product.errors[:base]).to include('A part-based product cannot have variants')
      end
    end
  end
end
