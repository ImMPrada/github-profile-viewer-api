module Github
  class ProfileConsumer
    attr_reader :body, :code

    FIELDS_MAPPING = {
      nickname: 'login',
      avatar: 'avatar_url',
      url: 'html_url',
      name: 'name',
      company: 'company',
      blog: 'blog',
      email: 'email',
      bio: 'bio',
      twitter: 'twitter_username',
      public_repos_count: 'public_repos',
      public_gists_count: 'public_gists',
      followers_count: 'followers',
      followings_count: 'following',
      git_date: 'updated_at',
      location: 'location',
      join_date: 'created_at'
    }.freeze

    def initialize(username)
      self.username = username
    end

    def call
      github_response = ApiClient.new(username)
      github_response.fetch_profile_data
      self.github_profile = github_response.body
      self.code = github_response.code

      return unless github_response.code == 200

      build_response
    end

    private

    attr_writer :body, :code
    attr_accessor :github_profile, :username

    def build_response
      assembled_profile = {}
      FIELDS_MAPPING.each do |profile_field, gh_field|
        assembled_profile[profile_field] = github_profile[gh_field]
      end

      self.body = assembled_profile
    end
  end
end
