require 'rails_helper'

RSpec.describe Github::ProfileConsumer do
  describe 'consumer service response with the profile requested, if github user exists' do
    let(:github_api_call) { Github::ApiClient.new('octocat').call_for_github_profile_data }
    let(:github_user) { described_class.new('octocat') }
    let(:github_profile) { github_user.call }

    it { expect(github_profile[:name]).to eq(github_api_call[:body]['name']) }
  end

  describe 'consumer service response with the profile requested, if github user doesnt exist' do
    let(:github_user) { described_class.new('octocatanimposibleuser13213123213213123213') }
    let(:github_profile) { github_user.call }

    it { expect(github_profile).to eq(nil) }
  end
end
