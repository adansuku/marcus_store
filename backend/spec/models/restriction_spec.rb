require 'rails_helper'

RSpec.describe Restriction, type: :model do
  describe 'restrictions between part options' do
    let(:frame) { create(:part) }
    let(:wheels) { create(:part) }

    let(:source_option) { create(:part_option, part: frame, name: 'Full-Suspension') }
    let(:target_option) { create(:part_option, part: wheels, name: 'Mountain Wheels') }

    it 'creates a restriction successfully' do
      restriction = Restriction.create!(
        source_part_option: source_option,
        target_part_option: target_option,
        restriction_type: 'excludes'
      )

      expect(restriction).to be_valid
      expect(restriction.source_part_option).to eq(source_option)
      expect(restriction.target_part_option).to eq(target_option)
    end

    it 'is invalid with an invalid restriction_type' do
      restriction = Restriction.new(
        source_part_option: source_option,
        target_part_option: target_option,
        restriction_type: 'invalid_type'
      )

      expect(restriction).not_to be_valid
      expect(restriction.errors[:restriction_type]).to include('is not included in the list')
    end
  end
end
