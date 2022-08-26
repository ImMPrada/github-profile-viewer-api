require 'rails_helper'

RSpec.describe Api::V1::ProfilesController, type: :controller do
  render_views

  describe '#show' do
    let(:user_nickname) { 'spec_user' }

    before do
      profile_call_fetch_profile = instance_double(
        Sync::FetchProfile,
        call: {},
        github_code: github_code,
        profile: profile
      )
      allow(Sync::FetchProfile).to receive(:new).and_return(profile_call_fetch_profile)

      params = { id: user_nickname }
      get :show, params: params, as: :json
    end

    describe 'when profile exists' do
      let(:languages) { create_list(:language, 10) }
      let(:repo) { create(:repo, profile: profile, languages: languages) }
      let(:profile) { create(:profile, nickname: user_nickname, languages: languages) }

      describe 'When github_code returns 200' do
        let(:github_code) { 200 }

        it 'returns 200' do
          expect(response.status).to eq(200)
        end

        it 'returns nil message' do
          parsed_response = JSON.parse(response.body)
          expect(parsed_response['message']).to be_nil
        end

        it 'returns right profile' do
          parsed_response = JSON.parse(response.body)
          expect(parsed_response['profile']['login']).to eq(user_nickname)
        end
      end

      describe 'When github_code returns 403' do
        let(:github_code) { 403 }

        it 'returns 200' do
          expect(response.status).to eq(200)
        end

        it 'returns "May be out of date" message' do
          parsed_response = JSON.parse(response.body)
          expect(parsed_response['message']).to eq('May be out of date')
        end

        it 'returns right profile' do
          parsed_response = JSON.parse(response.body)
          expect(parsed_response['profile']['login']).to eq(user_nickname)
        end
      end
    end

    describe "when profile doesn't exist (github_code returns 404)" do
      let(:github_code) { 404 }
      let(:profile) { nil }

      it 'returns 200' do
        expect(response.status).to eq(200)
      end

      it 'returns "User not found" message' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['message']).to eq('User not found')
      end

      it 'returns nil profile' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['profile']).to be_nil
      end
    end
  end
end
