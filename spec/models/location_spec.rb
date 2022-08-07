require 'rails_helper'

RSpec.describe Location, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:profiles) }
  end

  describe 'validations' do
    subject(:location) { create(:location) }

    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'a nickname allready registered, can\'t be saved, and is no case sensitive' do
    let(:location) { create(:location) }
    let(:location2) { build(:location, name: location.name) }
    let(:location3) { build(:location, name: location.name.upcase) }

    it { expect(location2).not_to be_valid }
    it { expect(location3).not_to be_valid }
  end

  describe 'location must has many profiles' do
    let(:location) { create(:location) }
    let(:location2) { create(:location) }
    before do
      create_list(:profile, 4, location: location)
      create_list(:profile, 3, location: location2)
    end

    it { expect(location.profiles.size).to eq(4) }
    it { expect(location2.profiles.size).to eq(3) }
  end
end
