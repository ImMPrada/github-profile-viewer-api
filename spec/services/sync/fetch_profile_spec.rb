require 'rails_helper'

RSpec.describe Sync::FetchProfile do
  let(:profile_name) { 'immprada' }
  let(:profile_url) { 'https://github.com/ImMPrada' }
  let(:fetch_profile) { described_class.new(profile_name) }
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
      location: 'Colombia',
      public_gists_count: 20,
      public_repos_count: 60,
      twitter: 'im_mprada'
    }
  end

  describe '#call' do
    before do
      profile_response = instance_double(
        Github::ProfileConsumer,
        call: nil
      )
      allow(Github::ProfileConsumer).to receive(:new).and_return(profile_response)
      profile = Profile.find_by(nickname: profile_name)
      profile.destroy if profile.present?
    end

    it 'returns nill if a profile is not found at Github and DB' do
      expect(fetch_profile.call).to be_nil
    end
  end

  describe '#call with profile not existing in the DB but existing on github' do
    before do
      profile_response = instance_double(
        Github::ProfileConsumer,
        call: profile_data
      )
      allow(Github::ProfileConsumer).to receive(:new).and_return(profile_response)
      null_repo_consumer_response = instance_double(
        Sync::FetchRepos,
        call: nil
      )
      allow(Sync::FetchRepos).to receive(:new).and_return(null_repo_consumer_response)
    end

    it 'saves profile data in DB' do
      fetch_profile.call
      expect(Profile.find_by(nickname: profile_name)).not_to be_nil
    end

    it 'returns the right profile form DB' do
      expect(fetch_profile.call.url).to eq(profile_url)
    end
  end
end
