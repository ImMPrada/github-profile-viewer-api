module Sync
  class FetchProfile
    attr_reader :profile, :github_code

    def initialize(profile_name)
      self.profile_name = profile_name
    end

    def call
      self.profile = Profile.find_by(nickname: profile_name)
      call_github_data
      return if profile.blank? && github_profile.blank?

      if github_code == 404
        delete_profile
        return
      end

      create_profile_if_not_exists
      synchronize_profile

      profile
    end

    private

    attr_writer :profile, :github_code
    attr_accessor :profile_name, :github_profile

    def call_github_data
      profile_consumer = Github::ProfileConsumer.new(profile_name)
      profile_consumer.call
      self.github_profile = profile_consumer.body
      self.github_code = profile_consumer.code
    end

    def delete_profile
      Sync::SyncProfile.new(github_profile).delete_profile(profile)
      self.profile = nil
    end

    def create_profile_if_not_exists
      return unless profile.nil?

      self.profile = Sync::SyncProfile.new(github_profile).create_profile
    end

    def synchronize_profile
      return if github_profile.blank?

      profile_date = profile.git_date
      github_profile_date = Date.parse(github_profile[:git_date])

      Sync::SyncProfile.new(github_profile).update_profile(profile) if profile_date < github_profile_date
      Sync::FetchRepos.new(profile).call
    end
  end
end
