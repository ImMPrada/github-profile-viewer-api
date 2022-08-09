module Github
  class ProfileConsumer
    attr_accessor :github_profile, :github_profile_response_code

    def initialize(user_name)
      github_response = ApiClient.new(user_name).call_for_github_profile_data
      self.github_profile_response_code = github_response[:code]
      self.github_profile = github_response[:body]
    end

    def call
      return nil unless github_profile_response_code == 200

      build_response
    end

    private

    def build_response
      build_personal_info.merge(build_data_info)
    end

    def build_personal_info
      {
        nickname: github_profile['login'],
        avatar_url: github_profile['avatar_url'],
        url: github_profile['html_url'],
        name: github_profile['name'],
        company: github_profile['company'],
        blog: github_profile['blog'],
        email: github_profile['email'],
        bio: github_profile['bio']
      }
    end

    def build_data_info
      {
        twitter_username: github_profile['twitter_username'],
        public_repos_count: github_profile['public_repos'],
        public_gists_count: github_profile['public_gists'],
        followers_count: github_profile['followers'],
        following_count: github_profile['following'],
        git_date: github_profile['updated_at'],
        location: github_profile['location']
      }
    end
  end
end
