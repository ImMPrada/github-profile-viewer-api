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
        join_date: '2022-01-03T00:16:27Z',
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
            'avatar_url' => 'https://avatars.githubusercontent.com/u/26731448?v=4',
            'html_url' => 'https://github.com/ImMPrada',
            'name' => 'miguel',
            'bio' => nil,
            'blog' => 'https://www.linkedin.com/in/immprada/',
            'company' => nil,
            'email' => nil,
            'followers' => 6,
            'following' => 6,
            'updated_at' => '2022-08-03T00:16:27Z',
            'created_at' => '2022-01-03T00:16:27Z',
            'location' => 'Colombia',
            'public_gists' => 0,
            'public_repos' => 15,
            'twitter_username' => 'im_mprada'
          }
      )
      allow(Github::ApiClient).to receive(:new).and_return(profile_response)
    end

    it 'returns right body class' do
      profile_consumer.call
      expect(profile_consumer.body.class).to eq(Hash)
    end

    it 'returns right code' do
      profile_consumer.call
      expect(profile_consumer.code).to eq(200)
    end

    it 'returns right body content' do
      profile_consumer.call
      expect(profile_consumer.body).to eq(expected_response)
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
      profile_consumer.call
      expect(profile_consumer.body.class).to eq(NilClass)
    end

    it 'returns right code' do
      profile_consumer.call
      expect(profile_consumer.code).to eq(403)
    end

    it 'returns right body content' do
      profile_consumer.call
      expect(profile_consumer.body).to be_nil
    end
  end
end
