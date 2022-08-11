module Github
  class ReposConsumer
    attr_accessor :github_repos, :github_repos_response_code

    GITHUB_RESPONSE_FIELDS = %w[name html_url description updated_at].freeze
    PROFILE_FIELDS = %i[name url description git_date].freeze

    def initialize(user_name)
      github_response = ApiClient.new(user_name).call_for_github_profile_repos
      self.github_repos_response_code = github_response[:code]
      self.github_repos = github_response[:body]
    end

    def call
      return nil unless github_repos_response_code == 200

      build_response
    end

    private

    def build_response
      github_repos.map { |repo| build_repo_response(repo) }
    end

    def build_repo_response(repo)
      assambled_repo = {}
      (0...GITHUB_RESPONSE_FIELDS.size).each do |i|
        assambled_repo[PROFILE_FIELDS[i]] = repo[GITHUB_RESPONSE_FIELDS[i]]
      end
      assambled_repo.merge({ is_active: true })
    end
  end
end
