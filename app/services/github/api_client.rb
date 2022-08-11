module Github
  class ApiClient
    attr_accessor :username, :code, :body

    BASE_URL = 'https://api.github.com'

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
