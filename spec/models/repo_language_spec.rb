require 'rails_helper'

RSpec.describe RepoLanguage, type: :model do
  describe 'associations' do
    it { should belong_to(:repo) }
    it { should belong_to(:language) }
  end

  describe 'validations' do
    subject(:repo_language) { create(:repo_language, repo: repo, language: language) }
    let(:language) { create(:language) }
    let(:repo) { create(:repo, profile: profile) }
    let(:profile) { create(:profile, location: location) }
    let(:location) { create(:location) }

    it 'should be valid' do
      expect(repo_language).to be_valid
    end
    it 'should not be valid with null repo' do
      repo_language.repo = nil
      expect(repo_language).not_to be_valid
    end
    it 'should not be valid with null language' do
      repo_language.language = nil
      expect(repo_language).not_to be_valid
    end
  end
end
