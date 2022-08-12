module Sync
  class FetchProfile
    def initialize(profile_name)
      self.profile_name = profile_name
    end

    def call
      profile = Profile.find_by(nickname: profile_name)
      github_profile = Github::ProfileConsumer.new(profile_name).call

      unless profile
        profile = Sync::SyncProfile.new(profile, github_profile).create_profile
        Sync::FetchRepos.new(profile).call
      end
    end

    private

    attr_accessor :profile_name
  end
end
