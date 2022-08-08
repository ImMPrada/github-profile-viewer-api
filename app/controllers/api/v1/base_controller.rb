module Api
  module V1
    class BaseController < Api::BaseController
      BASER_URL = 'https://api.github.com'

      def get_github_profile_data(user_name)
        github_response = RestClient.get("#{BASER_URL}/users/#{user_name}")
        { code: github_response.code, body: JSON.parse(github_response.body) }
      end
    end
  end
end
