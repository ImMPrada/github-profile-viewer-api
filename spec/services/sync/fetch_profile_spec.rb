require 'rails_helper'

RSpec.describe Sync::FetchProfile do
  let(:profile_name) { 'immprada' }
  let(:fetch_profile) { described_class.new(profile_name) }
  # let(:prfile_consumer) { Github::ProfileConsumer.new(profile_name) }

  describe '#call' do
    before do
      profile_response = instance_double(
        Github::ProfileConsumer,
        call: nil
      )
      allow(Github::ProfileConsumer).to receive(:new).and_return(profile_response)
      profile = Profile.find_by(nickname: profile_name)
      profile.destroy if profile.present?
    end

    it 'returns nill if a profile is not found at Github or DB' do
      expect(fetch_profile.call).to be_nil
    end
  end
end
