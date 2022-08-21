require 'rails_helper'

RSpec.describe Sync::FetchRepos do
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
      twitter: 'im_mprada'
    }
  end
  let(:profile) { create(:profile, profile_data) }
  let(:fetch_repos) { described_class.new(profile) }

  describe '#call' do
    describe 'repos from Github: []' do
      before do
        repos_response = instance_double(
          Github::ReposConsumer,
          call: []
        )
        allow(Github::ReposConsumer).to receive(:new).and_return(repos_response)
      end

      it 'returns []' do
        expect(fetch_repos.call).to eq([])
      end
    end
  end
end
