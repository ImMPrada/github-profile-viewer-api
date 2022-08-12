module Sync
  class SyncProfile
    def initialize(profile_data)
      self.profile_data = profile_data
    end

    def create_profile
      self.profile = Profile.new
      assign_attributes

      profile
    end

    def update_profile(current_profile)
      self.profile = current_profile
      assign_attributes

      profile
    end

    private

    attr_accessor :profile_data, :profile

    def assign_attributes
      profile_params = profile_data.merge(
        location: Location.find_or_create_by(name: profile_data[:location]),
        git_date: profile_data[:git_date]
      )

      profile.attributes = profile_params
      profile.save
    end
  end
end
