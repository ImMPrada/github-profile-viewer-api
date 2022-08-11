module Github
  class RepoLanguagesConsumer
    attr_accessor :repo_name, :github_repo_languages, :github_repo_languages_response_code

    def initialize(user_name, repo_name)
      github_response = ApiClient.new(user_name).get_repo_languages(repo_name)
      self.github_repo_languages_response_code = github_response[:code]
      self.github_repo_languages = github_response[:body]
      self.repo_name = repo_name
    end

    def call
      return nil unless github_repo_languages_response_code == 200

      build_response
    end

    private

    def build_response
      languages = []
      github_repo_languages.each do |language, amount| 
        languages.push(build_languages_response(repo_name, language, amount))
      end

      languages
    end

    def build_languages_response(repo_name, language, amount)
      {
        repo: repo_name,
        name: language,
        amount: amount
      }
    end
  end
end
