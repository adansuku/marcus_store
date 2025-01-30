require 'rails_helper'

RSpec.describe PricingRule, type: :model do
  describe 'valid instances' do
    let(:part_option) { create(:part_option, name: 'Matte Finish') }
    let(:dependent_part_option) { create(:part_option, name: 'Diamond Frame') }

    it 'is valid with valid attributes' do
      pricing_rule = build(:pricing_rule, part_option:, dependent_part_option:, price: 50.0)
      expect(pricing_rule).to be_valid
    end
  end

  describe 'invalid instances' do
    it 'is invalid without a price adjustment' do
      pricing_rule = build(:pricing_rule, price: nil)
      expect(pricing_rule).not_to be_valid
      expect(pricing_rule.errors[:price]).to include("is not a number")
    end

    it 'is invalid with a negative price adjustment' do
      pricing_rule = build(:pricing_rule, price: -10.0)
      expect(pricing_rule).not_to be_valid
      expect(pricing_rule.errors[:price]).to include("must be greater than or equal to 0")
    end
  end

  describe 'associations with part options' do
    it 'is valid with associated part options' do
      part_option = create(:part_option, name: 'Full-Suspension')
      dependent_part_option = create(:part_option, name: 'Mountain Wheels')
      pricing_rule = create(:pricing_rule, part_option:, dependent_part_option:)

      expect(pricing_rule.part_option).to eq(part_option)
      expect(pricing_rule.dependent_part_option).to eq(dependent_part_option)
    end
  end
end
