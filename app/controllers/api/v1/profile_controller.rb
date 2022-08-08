module Api
  module V1
    class ProfileController < Api::V1::BaseController
      def show
        github_id = filter_params[:github_profile]
        @profile = Profile.find_by(nickname: github_id)

        github_response = get_github_profile_data github_id
        byebug
        create_profile github_response[:body] unless @profile

        render json: { message: "profile show #{github_id}" }, status: :ok
      end

      private

      def filter_params
        params.permit(:github_profile)
      end

      def create_profile(github_response)
        location = Location.find_or_create_by(name: github_response['location'].downcase)

        Profile.create(
          nickname: github_response['login'],
          avatar: github_response['avatar_url'],
          url: github_response['html_url'],
          name: github_response['name'],
          company: github_response['company'],
          blog: github_response['blog'],
          bio: github_response['bio'],
          twitter: github_response['twitter_username'],
          public_repos_count: github_response['public_repos'],
          public_gists_count: github_response['public_gists'],
          followers_count: github_response['followers'],
          followings_count: github_response['following'],
          git_date: github_response['created_at'],
          location: location
        )
      end
    end
  end
end
