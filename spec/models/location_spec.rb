require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'associations' do
    it { should have_many(:profiles) }
  end

  describe 'validations' do
    let(:location) { create(:location) }
    let(:duplicate_location) { create(:location) }

    it 'should not be valid with blank or null name' do
      wrong_location = location
      wrong_location.name = ''
      expect(wrong_location).not_to be_valid
      wrong_location = location
      wrong_location.name = nil
      expect(wrong_location).not_to be_valid
    end
    it 'should not be valid if name is already takken' do
      duplicate_location.name = location.name
      expect(duplicate_location).not_to be_valid
    end
    it 'should not be case sensitive, at name uniqueness validation' do
      duplicate_location.name = location.name.downcase
      expect(duplicate_location).not_to be_valid
      duplicate_location.name = location.name.upcase
      expect(duplicate_location).not_to be_valid
    end
  end
end
