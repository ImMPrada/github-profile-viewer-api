require 'rails_helper'

RSpec.describe Github::RepoLanguagesConsumer do
  describe 'consumer is same size as github api response' do
    let(:github_api_init) { Github::ApiClient.new('immprada') }
    let(:github_api_call) { github_api_init.call_for_github_profile_repos }
    let(:github_api_repo) { github_api_call[:body][0]['name'] }
    let(:github_api_repo_languages_call) { github_api_init.get_github_repo_languages(github_api_repo)[:body] }

    let(:repo_languages_consumer) { described_class.new('immprada', github_api_repo) }
    let(:repo_languages_consumer_call) { repo_languages_consumer.call }


    it 'build the repo data, based on github api response' do
      repo_languages_consumer_call.each do |repo_language|
        expect(github_api_repo_languages_call[repo_language[:name]]).to eq(repo_language[:amount])
      end
    end
  end
end
