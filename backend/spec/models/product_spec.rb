# spec/models/product_spec.rb
require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'custom validations' do
    context 'when product is variant_based' do
      let(:variant_product) { create(:product, product_type: "variant_based") }

      it 'is valid with variants' do
        expect(variant_product).to be_valid
      end
    end

    context 'when product is part_based' do
      let(:part_product) { create(:part_based_product) }

      it 'is valid with parts' do
        expect(part_product).to be_valid
      end
    end
  end
end
