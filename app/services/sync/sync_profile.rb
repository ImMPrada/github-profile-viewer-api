module Sync
  class SyncProfile
    attr_accessor :github_profile, :profile

    def initialize(profile, github_profile)
      self.profile = profile
      self.github_profile = github_profile
    end

    def create_profile
      new_profile = Profile.new
      fetch_data new_profile
      fetch_location new_profile
      fetch_date new_profile

      new_profile.save
      new_profile
    end

    private

    def fetch_data(this_profile)
      this_profile.nickname = github_profile[:nickname]
      this_profile.avatar = github_profile[:avatar_url]
      this_profile.url = github_profile[:url]
      this_profile.name = github_profile[:name]
      this_profile.company = github_profile[:company]
      this_profile.blog = github_profile[:blog]
      this_profile.email = github_profile[:email]
      this_profile.bio = github_profile[:bio]
      this_profile.twitter = github_profile[:twitter_username]
      this_profile.public_repos_count = github_profile[:public_repos_count]
      this_profile.public_gists_count = github_profile[:public_gists_count]
      this_profile.followers_count = github_profile[:followers_count]
      this_profile.followings_count = github_profile[:following_count]

      this_profile
    end

    def fetch_location(this_profile)
      this_location = Location.find_or_create_by name: github_profile[:location]
      this_profile.location = this_location

      this_profile
    end

    def fetch_date(this_profile)
      this_date = Date.parse github_profile[:git_date]
      this_profile.git_date = this_date

      this_profile
    end
  end
end
