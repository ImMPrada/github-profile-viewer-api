module Github
  class RepoLanguagesConsumer
    def initialize(username, repo_name)
      self.username = username
      self.repo_name = repo_name
    end

    def call
      github_response = ApiClient.new(username)
      github_response.fetch_repo_languages(repo_name)
      self.github_repo_languages = github_response.body

      return unless github_response.code == 200

      build_response
    end

    private

    attr_accessor :username, :repo_name, :github_repo_languages

    def build_response
      github_repo_languages.map { |language, amount| build_languages_response(language, amount) }
    end

    def build_languages_response(language, amount)
      {
        repo_name: repo_name,
        name: language,
        amount: amount
      }
    end
  end
end
