require 'rails_helper'

RSpec.describe Sync::SyncProfile do
  let(:profile_name) { 'immprada' }
  let(:profile_url) { 'https://github.com/ImMPrada' }
  let(:profile_data) do
    {
      nickname: 'ImMPrada',
      avatar: 'https://avatars.githubusercontent.com/u/26731448?v=4',
      name: 'miguel',
      url: profile_url,
      bio: nil,
      blog: 'https://www.linkedin.com/in/immprada/',
      company: nil,
      email: nil,
      followers_count: 10,
      followings_count: 6,
      git_date: '2022-08-03T00:16:27Z',
      public_gists_count: 20,
      public_repos_count: 60,
      twitter: 'im_mprada',
      location: 'Colombia'
    }
  end
  let(:initialized_sync) { described_class.new(profile_data) }

  describe '#create_profile' do
    it 'returns a Profile' do
      expect(initialized_sync.create_profile).to be_a(Profile)
    end

    it 'creates profile on DB' do
      initialized_sync.create_profile
      expect(Profile.find_by(nickname: profile_name)).not_to be_nil
    end
  end

  describe '#update_profile' do
    let(:existing_profile) { create(:profile, nickname: profile_name, git_date: '2019-08-03T00:16:27Z', url: 'a') }

    before do
      existing_profile
    end

    it 'returns a Profile' do
      expect(initialized_sync.update_profile(existing_profile)).to be_a(Profile)
    end

    it 'updates the profile' do
      initialized_sync.update_profile(existing_profile)
      profile = Profile.find_by(nickname: profile_name)
      updated_date = Date.parse profile_data[:git_date]
      check_points = profile.url == profile_url && profile.git_date == updated_date

      expect(check_points).to eq(true)
    end
  end
end
