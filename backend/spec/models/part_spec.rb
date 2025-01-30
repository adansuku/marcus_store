require 'rails_helper'

RSpec.describe PartOption, type: :model do
  describe 'restrictions' do
    let(:frame) { create(:part) }
    let(:wheels) { create(:part) }

    let(:source_option) { create(:part_option, part: frame, name: 'Full-Suspension') }
    let(:target_option) { create(:part_option, part: wheels, name: 'Mountain Wheels') }

    it 'can have source restrictions' do
      restriction = create(:restriction, source_part_option: source_option, target_part_option: target_option, restriction_type: 'excludes')

      expect(source_option.source_restrictions).to include(restriction)
    end

    it 'can have target restrictions' do
      restriction = create(:restriction, source_part_option: source_option, target_part_option: target_option, restriction_type: 'excludes')

      expect(target_option.target_restrictions).to include(restriction)
    end
  end
end
