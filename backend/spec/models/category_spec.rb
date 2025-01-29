require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'factories' do
    it 'creates a valid category' do
      category = create(:category)
      expect(category).to be_valid
    end
  end

  describe 'hierarchy' do
    let(:parent_category) { create(:category, name: 'Parent Category') }
    let(:child_category) { create(:category, :with_parent, name: 'Child Category', parent_category: parent_category) }

    it 'allows categories to be nested' do
      expect(child_category.parent_category).to eq(parent_category)
    end
  end
end
