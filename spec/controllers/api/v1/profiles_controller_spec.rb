require 'rails_helper'

RSpec.describe Api::V1::ProfilesController, type: :controller do
  render_views
  let(:user_nickname) { 'spec_user' }
  let(:languages) { create_list(:language, 3) }
  let(:profile) { create(:profile, nickname: user_nickname) }
  let(:repos) { create_list(:repo, 2, profile: profile) }
  let(:repo_languages1) { languages.map { |language| create(:repo_language, language: language, repo: repos[0]) } }
  let(:repo_languages2) { languages.map { |language| create(:repo_language, language: language, repo: repos[1]) } }
  let(:profile_languages) do
    languages.map { |language| create(:profile_language, language: language, profile: profile) }
  end

  describe '#show' do
    describe 'When FetchProfile return code 200' do
      before do
        repo_languages1
        repo_languages2
        profile_languages

        profile_call_fetch_profile = instance_double(
          Sync::FetchProfile,
          call: {},
          code: 200,
          body: profile
        )
        allow(Sync::FetchProfile).to receive(:new).and_return(profile_call_fetch_profile)

        params = { id: user_nickname }
        get :show, params: params, as: :json
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
      end

      it 'returns nil message' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to be_nil
      end

      it 'returns right profile in the body' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['profile']['login']).to eq(user_nickname)
      end
    end

    describe 'When FetchProfile return code 404' do
      before do
        profile_call_fetch_profile = instance_double(
          Sync::FetchProfile,
          call: {},
          code: 404,
          body: nil
        )
        allow(Sync::FetchProfile).to receive(:new).and_return(profile_call_fetch_profile)

        params = { id: user_nickname }
        get :show, params: params, as: :json
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
      end

      it 'returns "User not found" message' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('User not found')
      end

      it 'returns nil profile in the body' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['profile']).to be_nil
      end
    end

    describe 'When FetchProfile return code 403' do
      before do
        repo_languages1
        repo_languages2
        profile_languages

        profile_call_fetch_profile = instance_double(
          Sync::FetchProfile,
          call: {},
          code: 403,
          body: profile
        )
        allow(Sync::FetchProfile).to receive(:new).and_return(profile_call_fetch_profile)

        params = { id: user_nickname }
        get :show, params: params, as: :json
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
      end

      it 'returns "May be out of date" message' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('May be out of date')
      end

      it 'returns right profile in the body' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['profile']['login']).to eq(user_nickname)
      end
    end
  end
end
