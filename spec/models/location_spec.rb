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
    let(:profile1) { build(:profile, location: location) }
    let(:profile2) { build(:profile, location: location) }
    let(:profile3) { build(:profile, location: location) }
    let(:profile4) { build(:profile, location: location) }
    let(:profile5) { build(:profile, location: location2) }
    let(:profile6) { build(:profile, location: location2) }
    let(:profile7) { build(:profile, location: location2) }

    before do
      profile1.save
      profile2.save
      profile3.save
      profile4.save
      profile5.save
      profile6.save
      profile7.save
    end

    it { expect(location.profiles.size).to eq(4) }
    it { expect(location2.profiles.size).to eq(3) }
  end
end
