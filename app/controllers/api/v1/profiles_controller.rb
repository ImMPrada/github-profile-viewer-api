module Api
  module V1
    class ProfilesController < Api::V1::BaseController
      MESSAGES = {
        200 => nil,
        404 => 'User not found',
        403 => 'May be out of date'
      }.freeze

      def show
        user_id = params[:id]
        build_response(user_id)

        render json: { message: @message, profile: nil } unless @profile
      end

      private

      def build_response(user_id)
        profile_fetcher = Sync::FetchProfile.new(user_id)
        profile_fetcher.call
        @message = MESSAGES[profile_fetcher.github_code]
        @profile = profile_fetcher.profile
      end
    end
  end
end
