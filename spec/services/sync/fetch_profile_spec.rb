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
  let(:call_fetch_profile) { fetch_profile.call }

  describe '#call' do
    describe 'profile from Github: doesn\'t exist, profile from DB: doesn\'t exist' do
      before do
        profile_call_fetch_profile = instance_double(
          Github::ProfileConsumer,
          call: {},
          code: 404,
          body: nil
        )
        allow(Github::ProfileConsumer).to receive(:new).and_return(profile_call_fetch_profile)

        profile = Profile.find_by(nickname: profile_name)
        profile.destroy if profile.present?
      end

      it 'returns nil' do
        expect(call_fetch_profile).to be_nil
      end

      it 'returns nil body' do
        expect(fetch_profile.body).to be_nil
      end

      it 'returns the right code' do
        call_fetch_profile
        obtained_code = fetch_profile.code
        expect(obtained_code).to eq(404)
      end
    end

    describe 'profile from Github: exists, profile from DB: doesn\'t exist' do
      before do
        profile_call_fetch_profile = instance_double(
          Github::ProfileConsumer,
          call: {},
          code: 200,
          body: profile_data
        )
        allow(Github::ProfileConsumer).to receive(:new).and_return(profile_call_fetch_profile)
        null_repo_consumer_call_fetch_profile = instance_double(
          Sync::FetchRepos,
          call: nil
        )
        allow(Sync::FetchRepos).to receive(:new).and_return(null_repo_consumer_call_fetch_profile)
      end

      it 'saves profile data in DB' do
        call_fetch_profile
        expect(Profile.find_by(nickname: profile_name)).not_to be_nil
      end

      it 'returns the right code' do
        call_fetch_profile
        obtained_code = fetch_profile.code
        expect(obtained_code).to eq(200)
      end

      it 'returns the right profile from DB' do
        call_fetch_profile
        expect(fetch_profile.body.url).to eq(profile_url)
      end
    end

    describe 'profile from Github: exists, profile from DB: exists, and needs to be updated' do
      let(:existing_profile) { create(:profile, git_date: '2022-07-01T00:16:27Z') }

      before do
        profile_call_fetch_profile = instance_double(
          Github::ProfileConsumer,
          call: {},
          code: 200,
          body: profile_data
        )
        allow(Github::ProfileConsumer).to receive(:new).and_return(profile_call_fetch_profile)

        null_repo_consumer_call_fetch_profile = instance_double(
          Sync::FetchRepos,
          call: nil
        )
        allow(Sync::FetchRepos).to receive(:new).and_return(null_repo_consumer_call_fetch_profile)
      end

      it 'updates the profile in the DB' do
        call_fetch_profile
        from_db = Profile.find_by(nickname: profile_name)
        obtained = from_db.values_at(:followers_count, :followings_count, :public_gists_count, :public_repos_count)
        expected = profile_data.values_at(:followers_count, :followings_count, :public_gists_count, :public_repos_count)

        expect(obtained).to eq(expected)
      end

      it 'returns the right code' do
        call_fetch_profile
        obtained_code = fetch_profile.code
        expect(obtained_code).to eq(200)
      end

      it 'returns the profile updated, in the body' do
        call_fetch_profile
        obtained_profile = fetch_profile.body
        expect(obtained_profile).to eq(Profile.find_by(nickname: profile_name))
      end

      it 'returns the right profile from DB' do
        call_fetch_profile
        expect(Profile.find_by(nickname: profile_name)[:url]).to eq(profile_url)
      end
    end

    describe 'profile from Github: doesn\'t exist, profile from DB: exists' do
      let(:location)  { create(:location) }
      let(:profile) { create(:profile, nickname: profile_name, location: location) }

      before do
        profile_call_fetch_profile = instance_double(
          Github::ProfileConsumer,
          call: {},
          code: 404,
          body: nil
        )
        allow(Github::ProfileConsumer).to receive(:new).and_return(profile_call_fetch_profile)

        profile
      end

      it 'destroys the profile' do
        call_fetch_profile
        expect(Profile.find_by(nickname: profile_name)).to be_nil
      end

      it 'returns nil' do
        expect(call_fetch_profile).to be_nil
      end

      it 'returns nil body' do
        expect(fetch_profile.body).to be_nil
      end

      it 'returns the right code' do
        call_fetch_profile
        obtained_code = fetch_profile.code
        expect(obtained_code).to eq(404)
      end
    end
  end
end
