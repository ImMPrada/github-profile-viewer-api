require 'rails_helper'

RSpec.describe Repo, type: :model do
  describe 'associations' do
    it { should belong_to(:profile) }
    it { should have_many(:repo_languages) }
    it { should have_many(:languages) }
  end

  describe 'validations' do
    subject(:repo) { create(:repo, profile: create(:profile, location: create(:location))) }

    it 'should be valid' do
      expect(repo).to be_valid
    end
    it 'should not be valid with blank or null name' do
      repo.name = nil
      expect(repo).not_to be_valid
    end
    it 'should not be valid with blank or null url' do
      repo.url = nil
      expect(repo).not_to be_valid
    end
    it 'should be valid with blank or null description' do
      repo.description = nil
      expect(repo).to be_valid
    end
    it 'should not be valid with blank or null languages_url' do
      repo.languages_url = nil
      expect(repo).not_to be_valid
    end
    it 'should not be valid with blank or null git_date' do
      repo.git_date = nil
      expect(repo).not_to be_valid
    end
  end
end
