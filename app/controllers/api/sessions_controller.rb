class Api::SessionsController < ApiController
  #sign-in
  def create
      user = User.where(email: params[:email])
      if user&.valid_password?(params[:password])
        render json: user.authentication_token, status: :ok
      else
        render json: {
          messages: "Signed In Failed - Unauthorized"
        }, status: :unauthorized
      end
  end
end