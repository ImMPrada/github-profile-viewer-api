module Sync
  class SyncProfile
    def initialize(profile, github_profile)
      self.profile = profile
      self.github_profile = github_profile
    end

    def create_profile
      new_profile = Profile.new
      fetch_data new_profile
      new_profile.save

      new_profile
    end

    private

    attr_accessor :github_profile, :profile

    def fetch_data(this_profile)
      github_profile[:location] = Location.find_or_create_by name: github_profile[:location]
      github_profile[:git_date] = Date.parse github_profile[:git_date]
      this_profile.attributes = github_profile

      this_profile
    end
  end
end
