module Sync
  class FetchProfile
    def initialize(profile_name)
      self.profile_name = profile_name
    end

    def call
      self.profile = Profile.find_by(nickname: profile_name)
      self.github_profile = Github::ProfileConsumer.new(profile_name).call

      return if profile.blank? && github_profile.blank?

      create_profile_if_not_exists
      synchronize_profile

      profile
    end

    private

    attr_accessor :profile_name, :github_profile, :profile

    def create_profile_if_not_exists
      return unless profile.nil?

      self.profile = Sync::SyncProfile.new(github_profile).create_profile
    end

    def synchronize_profile
      profile_date = profile.git_date
      github_profile_date = Date.parse(github_profile[:git_date])

      Sync::SyncProfile.new(github_profile).update_profile(profile) if profile_date < github_profile_date
      Sync::FetchRepos.new(profile).call
    end
  end
end
