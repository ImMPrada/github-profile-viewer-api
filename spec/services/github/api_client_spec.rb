require 'rails_helper'

RSpec.describe Github::ApiClient do
  describe 'api response with code 200 for existign users' do
    let(:github_user) { described_class.new('octocat') }
    let(:github_profile) { github_user.get_github_profile_data }
    let(:github_profile_repos) { github_user.get_github_profile_repos }
    let(:first_github_repo) { github_profile_repos[:body].first }
    let(:github_profile_repo_languages) { github_user.get_github_repo_languages(first_github_repo['name']) }

    it { expect(github_profile[:code]).to eq(200) }
    it { expect(github_profile_repos[:code]).to eq(200) }
    it { expect(github_profile_repo_languages[:code]).to eq(200) }
  end

  describe 'api response with code 404 for inexistign users' do
    let(:github_user) { described_class.new('octocatimpossibleuserofgithub') }
    let(:github_profile) { github_user.get_github_profile_data }
    let(:github_profile_repos) { github_user.get_github_profile_repos }

    it { expect(github_profile[:code]).to eq(404) }
    it { expect(github_profile_repos[:code]).to eq(404) }
  end
end
