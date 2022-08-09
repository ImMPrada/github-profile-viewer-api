require 'rails_helper'

RSpec.describe Github::ProfileConsumer do
  describe 'consumer service response with the profile requested, if github user exists' do
    let(:github_user) { described_class.new('octocat') }
    let(:github_profile) { github_user.call }

    it { expect(github_profile[:name]).to eq('The Octocat') }
  end

  describe 'consumer service response with the profile requested, if github user doesnt exist' do
    let(:github_user) { described_class.new('octocdsadasdsadasdasdat') }
    let(:github_profile) { github_user.call }

    it { expect(github_profile).to eq(nil) }
  end
end
