require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  context 'is valid' do
    it 'has a valid factory' do
      expect(FactoryGirl.build(:category)).to be_valid
    end
  end

  context 'is invalid' do
    it 'without name' do
      category = FactoryGirl.build(:category, name: nil)
      category.valid?
      expect(category.errors[:name]).to include('can\'t be blank')
    end
  end
end