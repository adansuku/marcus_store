require 'rails_helper'

RSpec.describe VariantOption, type: :model do
  describe 'valid instance' do
    it 'is valid with valid attributes' do
      variant_option = build(:variant_option, option_name: 'Size', option_value: 'M')
      expect(variant_option).to be_valid
    end
  end

  describe 'invalid instance' do
    it 'is invalid without an option_name' do
      variant_option = build(:variant_option, option_name: nil)
      expect(variant_option).not_to be_valid
      expect(variant_option.errors[:option_name]).to include("can't be blank")
    end

    it 'is invalid without an option_value' do
      variant_option = build(:variant_option, option_value: nil)
      expect(variant_option).not_to be_valid
      expect(variant_option.errors[:option_value]).to include("can't be blank")
    end
  end
end
