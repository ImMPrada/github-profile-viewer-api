require 'rails_helper'

RSpec.describe ProfileLanguage, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:profile) }
    it { is_expected.to belong_to(:language) }
  end

  describe 'validations' do
    subject(:profile_language) { create(:profile_language, profile: profile, language: language) }

    let(:language) { create(:language) }
    let(:location) { create(:location) }
    let(:profile) { create(:profile, location: location) }

    it { expect(profile_language.profile).to eq(profile) }
    it { expect(profile_language.language).to eq(language) }
  end
end
