module Sync
  class FetchProfile
    attr_accessor :github_profile, :profile

    def initialize(profile_name)
      self.profile = Profile.find_by(nickname: profile_name)
      self.github_profile = Github::ProfileConsumer.new(profile_name).call
    end

    def call
      unless profile
        self.profile = Sync::SyncProfile.new(profile, github_profile).create_profile
        Sync::FetchRepos.new(profile).call
      end
    end
  end
end
