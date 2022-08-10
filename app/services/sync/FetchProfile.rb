module Sync
  class FetchProfile
    attr_accessor :github_profile, :profile

    def initialize(profile_name)
      self.profile = Profile.find_by(nickname: profile_name)
      self.github_profile = Github::ProfileConsumer.new(profile_name).call
    end

    def call
      unless profile
        self.profile = Sync::ProfileSync.new(profile, github_profile).create_profile
      end

      profile_needs_to_be_updated?
    end

    private

    def profile_needs_to_be_updated?
      profile[:git_date] < Date.parse(github_profile[:git_date])
    end
  end
end
