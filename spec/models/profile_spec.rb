require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'associations' do
    it { should belong_to(:location) }
    it { should have_many(:repos) }
    it { should have_many(:profile_languages) }
    it { should have_many(:languages) }
  end

  describe 'validations' do
    subject(:profile) { create(:profile, location: create(:location)) }
    subject(:profile_duplicate) { create(:profile, location: create(:location)) }

    it 'should be valid' do
      expect(profile).to be_valid
    end
    it 'should not be valid with blank or null nickname' do
      profile.nickname = nil
      expect(profile).not_to be_valid
    end
    it 'should not be valid with blank or null avatar' do
      profile.avatar = nil
      expect(profile).not_to be_valid
    end
    it 'should not be valid with blank or null url' do
      profile.url = nil
      expect(profile).not_to be_valid
    end
    it 'should not be valid with blank or null repos_url' do
      profile.repos_url = nil
      expect(profile).not_to be_valid
    end
    it 'should not be valid with blank or null public_repos' do
      profile.public_repos = nil
      expect(profile).not_to be_valid
    end
    it 'should not be valid with blank or null public_gists' do
      profile.public_gists = nil
      expect(profile).not_to be_valid
    end
    it 'should not be valid with blank or null followers' do
      profile.followers = nil
      expect(profile).not_to be_valid
    end
    it 'should not be valid with blank or null followings' do
      profile.followings = nil
      expect(profile).not_to be_valid
    end
    it 'should not be valid with blank or null git_date' do
      profile.git_date = nil
      expect(profile).not_to be_valid
    end
    it 'should not be valid if nickname is already takken' do
      profile_duplicate.nickname = profile.nickname
      expect(profile_duplicate).not_to be_valid
    end
    it 'should not be case sensitive, at nickname uniqueness validation' do
      profile_duplicate.nickname = profile.nickname.downcase
      expect(profile_duplicate).not_to be_valid
    end
  end
end
