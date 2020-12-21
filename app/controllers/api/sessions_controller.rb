class Api::SessionsController < ApiController
  before_action :authenticate_user!, only: :destroy

  def create
    if user = User.authenticate(sign_in_params)
      user.reset_authentication_token!
      render json: user.as_json(only: [:email, :authentication_token]), status: :created
    else
      render json: {
        messages: "Signed In Failed - Unauthorized",
      }, status: :unauthorized
    end
  end

  def destroy
    current_user.reset_authentication_token!
    render json: {
      messages: "Log out - Success",
    }, status: :ok
  end
  
  private
  def sign_in_params
    params.require(:session).permit(:email, :password)
  end
end
