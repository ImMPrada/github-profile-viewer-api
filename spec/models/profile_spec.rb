require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'associations' do
    it { should belong_to(:location) }
    it { should have_many(:repos) }
    it { should have_many(:profile_languages) }
    it { should have_many(:languages) }
  end

  describe 'profile model validations' do
    subject(:profile) { create(:profile, location: location) }
    subject(:profile_duplicate) { create(:profile, location: location) }

    let(:location) { create(:location) }

    it 'should be valid' do
      expect(profile).to be_valid
    end
    it 'should not be valid with blank or null nickname' do
      wrong_profile = profile
      wrong_profile.nickname = ''
      expect(wrong_profile).not_to be_valid
      wrong_profile = profile
      wrong_profile.nickname = nil
      expect(wrong_profile).not_to be_valid
    end
    it 'should not be valid with blank or null avatar' do
      wrong_profile = profile
      wrong_profile.avatar = ''
      expect(wrong_profile).not_to be_valid
      wrong_profile = profile
      wrong_profile.avatar = nil
      expect(wrong_profile).not_to be_valid
    end
    it 'should not be valid with blank or null url' do
      wrong_profile = profile
      wrong_profile.url = ''
      expect(wrong_profile).not_to be_valid
      wrong_profile = profile
      wrong_profile.url = nil
      expect(wrong_profile).not_to be_valid
    end
    it 'should not be valid with blank or null repos_url' do
      wrong_profile = profile
      wrong_profile.repos_url = ''
      expect(wrong_profile).not_to be_valid
      wrong_profile = profile
      wrong_profile.repos_url = nil
      expect(wrong_profile).not_to be_valid
    end
    it 'should not be valid with blank or null public_repos' do
      wrong_profile = profile
      wrong_profile.public_repos = ''
      expect(wrong_profile).not_to be_valid
      wrong_profile = profile
      wrong_profile.public_repos = nil
      expect(wrong_profile).not_to be_valid
    end
    it 'should not be valid with blank or null public_gists' do
      wrong_profile = profile
      wrong_profile.public_gists = ''
      expect(wrong_profile).not_to be_valid
      wrong_profile = profile
      wrong_profile.public_gists = nil
      expect(wrong_profile).not_to be_valid
    end
    it 'should not be valid with blank or null followers' do
      wrong_profile = profile
      wrong_profile.followers = ''
      expect(wrong_profile).not_to be_valid
      wrong_profile = profile
      wrong_profile.followers = nil
      expect(wrong_profile).not_to be_valid
    end
    it 'should not be valid with blank or null followings' do
      wrong_profile = profile
      wrong_profile.followings = ''
      expect(wrong_profile).not_to be_valid
      wrong_profile = profile
      wrong_profile.followings = nil
      expect(wrong_profile).not_to be_valid
    end
    it 'should not be valid with blank or null followings' do
      wrong_profile = profile
      wrong_profile.followings = ''
      expect(wrong_profile).not_to be_valid
      wrong_profile = profile
      wrong_profile.followings = nil
      expect(wrong_profile).not_to be_valid
    end
    it 'should not be valid if nickname is already takken' do
      profile_duplicate.nickname = profile.nickname
      expect(profile_duplicate).not_to be_valid
    end
    it 'should not be case sensitive, at nickname uniqueness validation' do
      profile_duplicate.nickname = profile.nickname.downcase
      expect(profile_duplicate).not_to be_valid
      profile_duplicate.nickname = profile.nickname.upcase
      expect(profile_duplicate).not_to be_valid
    end
  end
end
