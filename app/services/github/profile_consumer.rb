module Github
  class ProfileConsumer
    attr_accessor :github_profile, :github_profile_response_code

    GITHUB_RESPONSE_FIELDS = %w[login avatar_url html_url name company blog email bio twitter_username public_repos public_gists followers following updated_at location].freeze
    PROFILE_FIELDS = %i[nickname avatar_url url name company blog email bio twitter_username public_repos public_gists followers following git_date location].freeze

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
      assambled_profile = {}
      (0...GITHUB_RESPONSE_FIELDS.size).each do |i|
        assambled_profile[PROFILE_FIELDS[i]] = github_profile[GITHUB_RESPONSE_FIELDS[i]]
      end
      assambled_profile
    end
  end
end
