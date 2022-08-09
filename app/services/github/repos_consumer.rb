module Github
  class ReposConsumer
    attr_accessor :github_repos, :github_repos_response_code

    def initialize(user_name)
      github_response = ApiClient.new(user_name).get_github_profile_repos
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
      {
        name: repo['name'],
        url: repo['html_url'],
        description: repo['description'],
        is_active: true,
        git_date: repo['updated_at']
      }
    end
  end
end
