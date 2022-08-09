require 'rails_helper'

RSpec.describe Github::ReposConsumer do
  describe 'consumer is same size as github api response' do
    let(:github_api_cal) { Github::ApiClient.new('octocat').get_github_profile_repos }
    let(:github_user) { described_class.new('octocat') }
    let(:github_user_repos) { github_user.call }

    it { expect(github_user_repos.size).to eq(github_api_cal[:body].size) }
    it { expect(github_user_repos.pluck(:name)).to eq(github_api_cal[:body].pluck('name')) }
  end

  describe 'consumer returns nill if profile doesn\'t on github api' do
    let(:github_user) { described_class.new('octocatanimposibleuser13213123213213123213') }
    let(:github_user_repos) { github_user.call }

    it { expect(github_user_repos).to be(nil) }
  end
end
