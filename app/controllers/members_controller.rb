class MembersController < ApplicationController
    before_action :authenticate_user!

    def show
        begin
            user = get_user_from_token
            render json: {
              message: "You are in, yeah bro",
              user: user
            }
        rescue JWT::DecodeError => e
            render json: { message: 'Invalid JWT token', error: e.message }, status: :unauthorized
        rescue ActiveRecord::RecordNotFound => e
            render json: { message: 'User not found', error: e.message }, status: :not_found
        end
    end

    private

    def get_user_from_token
        jwt_payload = JWT.decode(request.header['Authorization'].split(' ')[1],
        Rails.application.credentials.devise[:jwt_secret_key]).first
        user_id = jwt_payload['sub']
        user = User.find(user_id.to_s)
    end
end
