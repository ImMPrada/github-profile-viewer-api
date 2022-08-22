require 'rails_helper'

RSpec.describe Sync::SyncRepo do
  let(:profile_name) { 'immprada' }
  let(:repo_name) { 'art_musseum' }
  let(:profile_url) { 'https://github.com/ImMPrada' }
  let(:repo_url) { 'URL:://art_musseum-url' }
  let(:location) { create(:location, name: 'Colombia') }
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
      location: location
    }
  end
  let(:repo_data) do
    {
      name: repo_name,
      description: '',
      url: repo_url,
      git_date: '2022-08-03T00:16:27Z',
      is_active: true
    }
  end
  let(:profile) { create(:profile, profile_data) }
  let(:initialized_sync) { described_class.new(profile, repo_data) }

  describe '#create_repo' do
    let(:response) { initialized_sync.create_repo }

    it 'returns a Repo' do
      expect(response).to be_a(Repo)
    end

    it 'creates repo on DB' do
      response
      expect(Repo.find_by(name: repo_name)).not_to be_nil
    end

    it 'associates the repo to the profile' do
      response
      profile_repos = profile.repos
      expect(profile_repos.find_by(name: repo_name)).not_to be_nil
    end
  end

  describe '#update_repo' do
    let(:existing_repo) { create(:repo, name: repo_name, git_date: '2019-08-03T00:16:27Z', url: 'a', profile: profile) }
    let(:response) { initialized_sync.update_repo(existing_repo) }

    before { existing_repo }

    it 'returns a Repo' do
      expect(response).to be_a(Repo)
    end

    it 'updates the repo' do
      response
      repo = Repo.find_by(name: repo_name)
      updated_date = Date.parse repo_data[:git_date]
      check_points = repo.url == repo_url && repo.git_date == updated_date

      expect(check_points).to eq(true)
    end
  end
end
