require 'rails_helper'

RSpec.describe Variant, type: :model do
  describe 'factories' do
    it 'creates a valid variant' do
      variant = create(:variant)
      expect(variant).to be_valid
    end
  end

  describe 'custom behavior' do
    let(:product) { create(:variant_based_product) }
    let(:variant) { create(:variant, product: product, sku: "TEST-SKU") }

    it 'associates with a product of type variant_based' do
      expect(variant.product.product_type).to eq('variant_based')
    end

    it 'associates multiple options to a variant' do
      create(:variant_option, variant: variant, option_name: "Color", option_value: "Red")
      create(:variant_option, variant: variant, option_name: "Size", option_value: "M")

      expect(variant.variant_options.count).to eq(2)
    end
  end
end
