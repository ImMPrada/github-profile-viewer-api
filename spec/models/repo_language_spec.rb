require 'rails_helper'

RSpec.describe RepoLanguage, type: :model do
  describe 'associations' do
    it { should belong_to(:repo) }
    it { should belong_to(:language) }
  end

  describe 'validations' do
    let(:repo_language) { create(:repo_language, repo: repo, language: language) }

    let(:language) { create(:language) }
    let(:repo) { create(:repo) }

    it { expect(repo_language.repo).to eq(repo) }
    it { expect(repo_language.language).to eq(language) }
  end
end
