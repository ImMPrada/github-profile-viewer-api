require 'rails_helper'

RSpec.describe ProfileLanguage, type: :model do
  describe 'associations' do
    it { should belong_to(:profile) }
    it { should belong_to(:language) }
  end

  describe 'validations' do
    subject(:profile_language) { create(:profile_language, profile: profile, language: language) }
    let(:language) { create(:language) }
    let(:profile) { create(:profile, location: location) }
    let(:location) { create(:location) }

    it 'should be valid' do
      expect(profile_language).to be_valid
    end
    it 'should not be valid with null profile' do
      profile_language.profile = nil
      expect(profile_language).not_to be_valid
    end
    it 'should not be valid with null language' do
      profile_language.language = nil
      expect(profile_language).not_to be_valid
    end
  end
end
