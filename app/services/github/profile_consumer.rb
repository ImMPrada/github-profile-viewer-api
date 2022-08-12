module Github
  class ProfileConsumer
    FIELD_MAPPING = {
      nickname: 'login',
      avatar_url: 'avatar_url',
      url: 'html_url',
      name: 'name',
      company: 'company',
      blog: 'blog',
      email: 'email',
      bio: 'bio',
      twitter_username: 'twitter_username',
      public_repos: 'public_repos',
      public_gists: 'public_gists',
      followers: 'followers',
      following: 'following',
      git_date: 'updated_at',
      location: 'location'
    }.freeze

    def initialize(username)
      self.username = username
    end

    def call
      github_response = ApiClient.new(username)
      github_response.fetch_profile_data
      self.github_profile = github_response.body

      return nil unless github_response.code == 200

      build_response
    end

    private

    attr_accessor :github_profile, :username

    def build_response
      assambled_profile = {}
      FIELD_MAPPING.each do |profile_field, gh_field|
        assambled_profile[profile_field] = github_profile[gh_field]
      end
      assambled_profile
    end
  end
end
