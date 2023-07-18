class Users::SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(_resource, _opts = {})
        render json: {
            message: 'you are logged inn',
            user: current_user
        }, status: :ok
    end

    def respond_to_on_destroy
        log_out_success && return if current_user

        log_out_failure
    end 

    def log_out_success
        render json: { message: 'you are out'}, status: :ok
    end

    def log_out_failure
        render json: { message: 'something went wrong'}, status: :anauthorized
    end
end