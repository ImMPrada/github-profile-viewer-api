module Github
  class ReposConsumer
    FIELD_MAPPING = {
      name: 'name',
      url: 'html_url',
      description: 'description',
      git_date: 'updated_at'
    }.freeze

    def initialize(username)
      self.username = username
    end

    def call
      github_response = ApiClient.new(username)
      github_response.fetch_profile_repos
      self.github_repos = github_response.body

      return nil unless github_response.code == 200

      build_response
    end

    private

    attr_accessor :github_repos, :username

    def build_response
      github_repos.map { |repo| build_repo_response(repo) }
    end

    def build_repo_response(repo)
      assambled_repo = {}
      FIELD_MAPPING.each do |repo_field, gh_field|
        assambled_repo[repo_field] = repo[gh_field]
      end
      assambled_repo.merge({ is_active: true })
    end
  end
end
