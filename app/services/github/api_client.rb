module Github
  class ApiClient
    attr_reader :code, :body

    BASE_URL = 'https://api.github.com'.freeze

    def initialize(username)
      self.username = username
    end

    def fetch_profile_data
      get_data("#{BASE_URL}/users/#{username}")
    end

    def fetch_profile_repos
      get_data("#{BASE_URL}/users/#{username}/repos")
    end

    def fetch_repo_languages(repo_name)
      get_data("#{BASE_URL}/repos/#{username}/#{repo_name}/languages")
    end

    private

    attr_accessor :username
    attr_writer :code, :body

    def get_data(url)
      github_response = RestClient.get(url)
      self.code = github_response.code
      self.body = JSON.parse(github_response.body)
    rescue RestClient::NotFound
      self.code = 404
      self.body = nil
    rescue RestClient::Forbidden
      self.code = 403
      self.body = nil
    end
  end
end
