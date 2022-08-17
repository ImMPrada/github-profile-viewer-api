require 'rails_helper'

RSpec.describe Github::ApiClient do
  let(:api_client) { described_class.new('username') }

  describe '#fetch_profile_data' do
    describe 'when the profile exists on github' do
      before do
        response = instance_double(RestClient::Response, code: 200, body: {}.to_json)
        allow(RestClient).to receive(:get).and_return(response)
        api_client.fetch_profile_data
      end

      it 'returns the response code' do
        expect(api_client.code).to eq(200)
      end

      it 'returns the response body' do
        expect(api_client.body).to eq({})
      end
    end

    describe 'when the profile doesn\'t exist on github' do
      before do
        allow(RestClient).to receive(:get).and_raise(RestClient::NotFound.new)
        api_client.fetch_profile_data
      end

      it 'returns the error code' do
        expect(api_client.code).to eq(404)
      end

      it 'returns the a nil body' do
        expect(api_client.body).to eq(nil)
      end
    end

    describe 'when github api is shutdown' do
      before do
        allow(RestClient).to receive(:get).and_raise(RestClient::Forbidden.new)
        api_client.fetch_profile_data
      end

      it 'returns the error code' do
        expect(api_client.code).to eq(403)
      end

      it 'returns the a nil body' do
        expect(api_client.body).to eq(nil)
      end
    end
  end

  describe '#fetch_profile_repos' do
    describe 'when the profile exists on github' do
      before do
        response = instance_double(RestClient::Response, code: 200, body: {}.to_json)
        allow(RestClient).to receive(:get).and_return(response)
        api_client.fetch_profile_repos
      end

      it 'returns the response code' do
        expect(api_client.code).to eq(200)
      end

      it 'returns the response body' do
        expect(api_client.body).to eq({})
      end
    end

    describe 'when the profile doesn\'t exist on github' do
      before do
        allow(RestClient).to receive(:get).and_raise(RestClient::NotFound.new)
        api_client.fetch_profile_repos
      end

      it 'returns the error code' do
        expect(api_client.code).to eq(404)
      end

      it 'returns the a nil body' do
        expect(api_client.body).to eq(nil)
      end
    end

    describe 'when github api is shutdown' do
      before do
        allow(RestClient).to receive(:get).and_raise(RestClient::Forbidden.new)
        api_client.fetch_profile_repos
      end

      it 'returns the error code' do
        expect(api_client.code).to eq(403)
      end

      it 'returns the a nil body' do
        expect(api_client.body).to eq(nil)
      end
    end
  end

  describe '#fetch_repo_languages' do
    describe 'when the profile, and a repo exists on github' do
      before do
        response = instance_double(RestClient::Response, code: 200, body: {}.to_json)
        allow(RestClient).to receive(:get).and_return(response)
        api_client.fetch_repo_languages('a_repo')
      end

      it 'returns the response code' do
        expect(api_client.code).to eq(200)
      end

      it 'returns the response body' do
        expect(api_client.body).to eq({})
      end
    end

    describe 'when the profile doesn\'t exist on github' do
      before do
        allow(RestClient).to receive(:get).and_raise(RestClient::NotFound.new)
        api_client.fetch_repo_languages('a_repo')
      end

      it 'returns the error code' do
        expect(api_client.code).to eq(404)
      end

      it 'returns the a nil body' do
        expect(api_client.body).to eq(nil)
      end
    end

    describe 'when github api is shutdown' do
      before do
        allow(RestClient).to receive(:get).and_raise(RestClient::Forbidden.new)
        api_client.fetch_repo_languages('a_repo')
      end

      it 'returns the error code' do
        expect(api_client.code).to eq(403)
      end

      it 'returns the a nil body' do
        expect(api_client.body).to eq(nil)
      end
    end
  end

end
