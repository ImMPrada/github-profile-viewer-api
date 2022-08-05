require 'rails_helper'

RSpec.describe Repo, type: :model do
  describe 'associations' do
    it { should belong_to(:profile) }
    it { should have_many(:repo_languages) }
    it { should have_many(:languages) }
  end

  describe 'validations' do
    subject(:repo) { create(:repo, profile: profile) }

    let(:location) { create(:location) }
    let(:profile) { create(:profile, location: location) }

    it 'should be valid' do
      expect(repo).to be_valid
    end
    it 'should not be valid with blank or null name' do
      wrong_repo = repo
      wrong_repo.name = ''
      expect(wrong_repo).not_to be_valid
      wrong_repo = repo
      wrong_repo.name = nil
      expect(wrong_repo).not_to be_valid
    end
    it 'should not be valid with blank or null url' do
      wrong_repo = repo
      wrong_repo.url = ''
      expect(wrong_repo).not_to be_valid
      wrong_repo = repo
      wrong_repo.url = nil
      expect(wrong_repo).not_to be_valid
    end
    it 'should be valid with blank or null description' do
      repo.description = ''
      expect(repo).to be_valid
      repo.description = nil
      expect(repo).to be_valid
    end
    it 'should not be valid with blank or null languages_url' do
      wrong_repo = repo
      wrong_repo.languages_url = ''
      expect(wrong_repo).not_to be_valid
      wrong_repo = repo
      wrong_repo.languages_url = nil
      expect(wrong_repo).not_to be_valid
    end
    it 'should not be valid with blank or null git_date' do
      wrong_repo = repo
      wrong_repo.git_date = ''
      expect(wrong_repo).not_to be_valid
      wrong_repo = repo
      wrong_repo.git_date = nil
      expect(wrong_repo).not_to be_valid
    end
  end
end
