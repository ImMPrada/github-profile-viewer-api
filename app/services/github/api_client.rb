module Github
  class ApiClient
    attr_accessor :user_name

    BASER_URL = 'https://api.github.com'

    def initialize(user_name)
      self.user_name = user_name
    end

    def get_github_profile_data
      get_data("#{BASER_URL}/users/#{user_name}")
    end

    def get_github_profile_repos
      get_data("#{BASER_URL}/users/#{user_name}/repos")
    end

    def get_github_repo_languages(repo_name)
      get_data("#{BASER_URL}/repos/#{user_name}/#{repo_name}/languages")
    end

    private

    def get_data(url)
      github_response = RestClient.get(url)
      { code: github_response.code, body: JSON.parse(github_response.body) }
    rescue RestClient::NotFound
      { code: 404, body: nil }
    end
  end
end