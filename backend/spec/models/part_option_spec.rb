require 'rails_helper'

RSpec.describe PartOption, type: :model do
  describe 'factories' do
    it 'creates a valid part option' do
      part_option = create(:part_option)
      expect(part_option).to be_valid
    end
  end
end
