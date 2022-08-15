require 'rails_helper'

RSpec.describe RepoLanguage, type: :model do
  describe 'associations' do
    it { should belong_to(:repo) }
    it { should belong_to(:language) }
  end

  describe 'validations' do
    subject(:repo_language) { create(:repo_language, repo: repo, language: language) }

    let(:language) { create(:language) }
    let(:location) { create(:location) }
    let(:profile) { create(:profile, location: location) }
    let(:repo) { create(:repo, profile: profile) }

    it { expect(repo_language).to be_valid }
  end
end
