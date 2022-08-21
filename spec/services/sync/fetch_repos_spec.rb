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

    describe 'repos from Github: exists' do
      before do
        repos_response = instance_double(
          Github::ReposConsumer,
          call: [
            {
              name: 'repo1',
              description: '',
              url: 'URL:://repo1',
              git_date: '2022-08-03T00:16:27Z',
              is_active: true
            },
            {
              name: 'repo2',
              description: '',
              url: 'URL:://repo2',
              git_date: '2022-08-03T00:16:27Z',
              is_active: true
            },
            {
              name: 'repo3',
              description: '',
              url: 'URL:://repo3',
              git_date: '2022-08-03T00:16:27Z',
              is_active: true
            }
          ]
        )
        allow(Github::ReposConsumer).to receive(:new).and_return(repos_response)

        languages_response = instance_double(
          Sync::FetchLanguages,
          call: []
        )
        allow(Sync::FetchLanguages).to receive(:new).and_return(languages_response)
      end

      it 'returns list of repos' do
        expect(fetch_repos.call.size).to eq(3)
      end

      it 'saves repos on DB' do
        fetch_repos.call
        expect(Profile.find_by(nickname: profile.nickname).repos.size).to eq(3)
      end
    end

    describe 'repos from Github: exists, from DB: updates' do
      let(:existing_repo1) { create(:repo, name: 'repo1', profile: profile, git_date: '2022-08-03T00:16:27Z') }
      let(:to_day_date) { Date.parse '2022-09-10T00:16:27Z' }

      before do
        repos_response = instance_double(
          Github::ReposConsumer,
          call: [
            {
              name: 'repo1',
              description: '',
              url: 'URL:://repo1_updated',
              git_date: '2022-09-10T00:16:27Z',
              is_active: true
            }
          ]
        )
        allow(Github::ReposConsumer).to receive(:new).and_return(repos_response)

        languages_response = instance_double(
          Sync::FetchLanguages,
          call: []
        )
        allow(Sync::FetchLanguages).to receive(:new).and_return(languages_response)

        existing_repo1
      end

      it 'returns updated repos' do
        repo_date = Date.parse fetch_repos.call.first[:git_date]
        expect(repo_date).to eq(to_day_date)
      end

      it 'updates repos on DB' do
        fetch_repos.call
        expect(Profile.find_by(nickname: profile.nickname).repos.first.git_date).to eq(to_day_date)
      end
    end
  end
end
