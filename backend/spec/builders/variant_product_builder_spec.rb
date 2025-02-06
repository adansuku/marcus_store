require 'rails_helper'

RSpec.describe VariantProductBuilder do
  let(:product) { create(:no_variant_product) }
 let(:builder) { described_class.new(product) }

  context 'when variant data is valid' do
    it 'builds variants successfully' do
      variants_data = [
        {
          sku: 'SKU-RED-M',
          price: 100,
          stock_quantity: 10,
          options: [{ name: 'Color', value: 'Red' }, { name: 'Size', value: 'M' }]
        }
      ]

      result = builder.build(variants_data)

      expect(result).to be true
      expect(product.variants.size).to eq(1)
      expect(product.variants.first.variant_options.size).to eq(2)
    end
  end

  context 'when variant data is invalid' do
    it 'returns errors for invalid variants' do
      variants_data = [
        {
          sku: '',
          price: -10, # Invalid price
          stock_quantity: 10,
          options: [{ name: 'Color', value: 'Red' }]
        }
      ]

      result = builder.build(variants_data)

      expect(result).to be false
      expect(builder.errors).to include("Variant is invalid: Sku can't be blank, Price must be greater than or equal to 0")
    end
  end

  context 'when option data is invalid' do
    it 'returns errors for invalid options' do
      variants_data = [
        {
          sku: 'SKU-RED-M',
          price: 100,
          stock_quantity: 10,
          options: [{ name: '', value: 'Red' }] # Invalid option name
        }
      ]

      result = builder.build(variants_data)

      expect(result).to be false
      expect(builder.errors).to include("Option is invalid: Option name can't be blank")
    end
  end

  context 'when no variants are provided' do
    it 'returns true with no errors' do
      variants_data = []

      result = builder.build(variants_data)

      expect(result).to be true
      expect(builder.errors).to be_empty
    end
  end
end
