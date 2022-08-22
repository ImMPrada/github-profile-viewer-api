require 'rails_helper'

RSpec.describe Sync::FetchLanguages do
  let(:profile_name) { 'immprada' }
  let(:profile_data) do
    {
      nickname: 'ImMPrada',
      avatar: 'https://avatars.githubusercontent.com/u/26731448?v=4',
      name: 'miguel',
      url: 'https://github.com/ImMPrada',
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
  let(:repo_data) do
    {
      name: 'art_musseum',
      description: '',
      url: 'URL:://art_musseum-url',
      git_date: '2022-08-03T00:16:27Z',
      is_active: true
    }
  end
  let(:repo) { build(:repo, repo_data) }
  let(:fetch_languages) { described_class.new(profile, repo) }
  let(:languages_data) do
    [
      {
        repo_name: 'art_musseum',
        name: 'JavaScript',
        amount: 198
      },
      {
        repo_name: 'art_musseum',
        name: 'SCSS',
        amount: 384
      },
      {
        repo_name: 'art_musseum',
        name: 'HTML',
        amount: 220
      }
    ]
  end
  let(:response) { fetch_languages.call }

  describe '#call' do
    describe 'languages for a repo, from Github: []' do
      before do
        repo.profile = profile
        repo.save
        languages_response = instance_double(
          Github::RepoLanguagesConsumer,
          call: []
        )
        allow(Github::RepoLanguagesConsumer).to receive(:new).and_return(languages_response)
      end

      it 'returns []' do
        expect(response).to eq([])
      end
    end

    describe 'languages for a repo, from Github: exists an array of languages' do
      before do
        repo.profile = profile
        repo.save
        languages_response = instance_double(
          Github::RepoLanguagesConsumer,
          call: languages_data
        )
        allow(Github::RepoLanguagesConsumer).to receive(:new).and_return(languages_response)
      end

      it 'returns an array of languages' do
        expect(response).to eq(languages_data)
      end

      it 'saves languages data on DB' do
        obtained_list_of_languages = response.pluck(:name).sort
        registered_list_of_languages = Profile.find_by(nickname: profile_name).repos.first.languages.pluck(:name).sort

        expect(obtained_list_of_languages).to eq(registered_list_of_languages)
      end
    end
  end
end
