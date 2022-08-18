require 'rails_helper'

RSpec.describe Github::ReposConsumer do
  let(:repos_consumer) { described_class.new('immprada') }

  describe 'when ApiClient code: 200' do
    let(:expected_response) do
      [
        {
          name: 'art_musseum',
          url: 'https://github.com/ImMPrada/art_musseum',
          description: nil,
          git_date: '2022-08-02T19:09:18Z',
          is_active: true
        }
      ]
    end

    before do
      repos_response = instance_double(
        Github::ApiClient,
        fetch_profile_repos: {},
        code: 200,
        body:
          [
            {
              'name' => 'art_musseum',
              'html_url' => 'https://github.com/ImMPrada/art_musseum',
              'description' => nil,
              'updated_at' => '2022-08-02T19:09:18Z',
              'homepage' => 'art-musseum.vercel.app'
            }
          ]
      )
      allow(Github::ApiClient).to receive(:new).and_return(repos_response)
    end

    it 'returns right body class' do
      expect(repos_consumer.call.class).to eq(Array)
    end

    it 'returns right body content' do
      expect(repos_consumer.call).to eq(expected_response)
    end
  end

  describe 'when ApiClient code: 4XX' do
    let(:expected_response) { nil }

    before do
      profile_response = instance_double(
        Github::ApiClient,
        fetch_profile_repos: {},
        code: 403,
        body: nil
      )
      allow(Github::ApiClient).to receive(:new).and_return(profile_response)
    end

    it 'returns right body class' do
      expect(repos_consumer.call.class).to eq(NilClass)
    end

    it 'returns right body content' do
      expect(repos_consumer.call).to eq(expected_response)
    end
  end
end
