require 'rails_helper'

RSpec.describe Sync::SyncLanguage do
  let(:profile_name) { 'immprada' }
  let(:repo_name) { 'art_musseum' }
  let(:language_name) { 'JavaScript' }
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
      is_active: true,
      profile: profile
    }
  end
  let(:languages_data) do
    {
      repo_name: 'art_musseum',
      name: language_name,
      amount: 198
    }
  end
  let(:profile) { create(:profile, profile_data) }
  let(:repo) { create(:repo, repo_data) }
  let(:initialized_sync) { described_class.new(profile, repo, languages_data) }

  describe '#synchronize' do
    it 'returns a Language' do
      expect(initialized_sync.synchronize).to be_a(Language)
    end

    it 'associates the language to the repo' do
      initialized_sync.synchronize
      repo_languages = Repo.find_by(name: repo_name).languages

      expect(repo_languages.find_by(name: language_name)).not_to be_nil
    end

    it 'associates the language to the profile' do
      initialized_sync.synchronize
      profile_languages = Profile.find_by(nickname: profile_name).languages

      expect(profile_languages.find_by(name: language_name)).not_to be_nil
    end
  end
end
