require 'rails_helper'

RSpec.describe Github::ProfileConsumer do
  let(:profile_consumer) { described_class.new('immprada') }

  describe 'when ApiClient code: 200' do
    let(:expected_response) do
      {
        nickname: 'ImMPrada',
        avatar: 'https://avatars.githubusercontent.com/u/26731448?v=4',
        name: 'miguel',
        url: 'https://github.com/ImMPrada',
        bio: nil,
        blog: 'https://www.linkedin.com/in/immprada/',
        company: nil,
        email: nil,
        followers_count: 6,
        followings_count: 6,
        git_date: '2022-08-03T00:16:27Z',
        location: 'Colombia',
        public_gists_count: 0,
        public_repos_count: 15,
        twitter: 'im_mprada'
      }
    end

    before do
      profile_response = instance_double(
        Github::ApiClient,
        fetch_profile_data: {},
        code: 200,
        body:
          {
            'login' => 'ImMPrada',
            'id' => 26_731_448,
            'node_id' => 'MDQ6VXNlcjI2NzMxNDQ4',
            'avatar_url' => 'https://avatars.githubusercontent.com/u/26731448?v=4',
            'gravatar_id' => '',
            'url' => 'https://api.github.com/users/ImMPrada',
            'html_url' => 'https://github.com/ImMPrada',
            'followers_url' => 'https://api.github.com/users/ImMPrada/followers',
            'following_url' => 'https://api.github.com/users/ImMPrada/following{/other_user}',
            'gists_url' => 'https://api.github.com/users/ImMPrada/gists{/gist_id}',
            'starred_url' => 'https://api.github.com/users/ImMPrada/starred{/owner}{/repo}',
            'subscriptions_url' => 'https://api.github.com/users/ImMPrada/subscriptions',
            'organizations_url' => 'https://api.github.com/users/ImMPrada/orgs',
            'repos_url' => 'https://api.github.com/users/ImMPrada/repos',
            'events_url' => 'https://api.github.com/users/ImMPrada/events{/privacy}',
            'received_events_url' => 'https://api.github.com/users/ImMPrada/received_events',
            'type' => 'User',
            'site_admin' => false,
            'name' => 'miguel',
            'company' => nil,
            'blog' => 'https://www.linkedin.com/in/immprada/',
            'location' => 'Colombia',
            'email' => nil,
            'hireable' => nil,
            'bio' => nil,
            'twitter_username' => 'im_mprada',
            'public_repos' => 15,
            'public_gists' => 0,
            'followers' => 6,
            'following' => 6,
            'created_at' => '2017-03-28T04:32:22Z',
            'updated_at' => '2022-08-03T00:16:27Z'
          }
      )
      allow(Github::ApiClient).to receive(:new).and_return(profile_response)
    end

    it 'returns right body class' do
      expect(profile_consumer.call.class).to eq(Hash)
    end

    it 'returns right body content' do
      expect(profile_consumer.call).to eq(expected_response)
    end
  end

  describe 'when ApiClient code: 4XX' do
    let(:expected_response) { nil }

    before do
      profile_response = instance_double(
        Github::ApiClient,
        fetch_profile_data: {},
        code: 403,
        body: nil
      )
      allow(Github::ApiClient).to receive(:new).and_return(profile_response)
    end

    it 'returns right body class' do
      expect(profile_consumer.call.class).to eq(NilClass)
    end

    it 'returns right body content' do
      expect(profile_consumer.call).to eq(expected_response)
    end
  end
end
