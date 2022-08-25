require 'rails_helper'

RSpec.describe Sync::FetchProfile do
  let(:profile_name) { 'immprada' }
  let(:profile_url) { 'https://github.com/ImMPrada' }
  let(:fetch_profile) { described_class.new(profile_name) }
  let(:profile_data) do
    {
      nickname: 'ImMPrada',
      avatar: 'https://avatars.githubusercontent.com/u/26731448?v=4',
      name: 'miguel',
      url: profile_url,
      bio: nil,
      blog: 'https://www.linkedin.com/in/immprada/',
      company: nil,
      email: nil,
      followers_count: 10,
      followings_count: 6,
      git_date: '2022-08-03T00:16:27Z',
      location: nil,
      public_gists_count: 20,
      public_repos_count: 60,
      twitter: 'im_mprada'
    }
  end

  describe '#call' do
    before do
      profile_call_fetch_profile = instance_double(
        Github::ProfileConsumer,
        call: {},
        code: github_response_code,
        body: github_response_body
      )
      allow(Github::ProfileConsumer).to receive(:new).and_return(profile_call_fetch_profile)
    end

    describe "when the profile doesn't exist in github" do
      let(:github_response_code) { 404 }
      let(:github_response_body) { nil }

      describe "when profile at DB doesn't exist" do
        it 'returns nil' do
          expect(fetch_profile.call).to be_nil
        end

        it 'returns nil body' do
          fetch_profile.call
          expect(fetch_profile.profile).to be_nil
        end

        it 'returns the right code' do
          fetch_profile.call
          expect(fetch_profile.github_code).to eq(404)
        end
      end

      describe 'when profile at DB exists' do
        before do
          location = create(:location)
          create(:profile, nickname: profile_name, location: location)
        end

        it 'destroys the profile' do
          fetch_profile.call
          expect(Profile.find_by(nickname: profile_name)).to be_nil
        end

        it 'returns nil' do
          expect(fetch_profile.call).to be_nil
        end

        it 'returns nil body' do
          fetch_profile.call
          expect(fetch_profile.profile).to be_nil
        end

        it 'returns the right code' do
          fetch_profile.call
          expect(fetch_profile.github_code).to eq(404)
        end
      end
    end

    describe 'when the profile exists in github' do
      let(:github_response_code) { 200 }
      let(:github_response_body) { profile_data }

      before do
        null_repo_consumer_call_fetch_profile = instance_double(
          Sync::FetchRepos,
          call: nil
        )
        allow(Sync::FetchRepos).to receive(:new).and_return(null_repo_consumer_call_fetch_profile)
      end

      describe "when profile from DB: doesn't exist" do
        it 'saves profile data in DB' do
          fetch_profile.call
          expect(Profile.find_by(nickname: profile_name)).not_to be_nil
        end

        it 'returns the right code' do
          fetch_profile.call
          expect(fetch_profile.github_code).to eq(200)
        end

        it 'returns the right profile from DB' do
          fetch_profile.call
          expect(fetch_profile.profile.url).to eq(profile_url)
        end
      end

      describe 'when profile from DB exists, and needs to be updated' do
        before do
          location = create(:location)
          create(:profile, nickname: profile_name, location: location)
        end

        it 'updates the profile in the DB' do
          fetch_profile.call
          from_db = Profile.find_by(nickname: profile_name)
          obtained = from_db.values_at(:followers_count, :public_gists_count, :public_repos_count)
          expected = profile_data.values_at(:followers_count, :public_gists_count, :public_repos_count)

          expect(obtained).to eq(expected)
        end

        it 'returns the right code' do
          fetch_profile.call
          expect(fetch_profile.github_code).to eq(200)
        end

        it 'returns the profile updated, in the body' do
          fetch_profile.call
          obtained_profile = fetch_profile.profile
          expect(obtained_profile).to eq(Profile.find_by(nickname: profile_name))
        end

        it 'returns the right profile from DB' do
          fetch_profile.call
          expect(Profile.find_by(nickname: profile_name)[:url]).to eq(profile_url)
        end
      end
    end
  end
end
