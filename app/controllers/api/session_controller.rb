class Api::SessionController < Devise::SessionsController
  protect_from_forgery prepend: true

  before_action :sign_in_params, only: :create
  before_action :load_user, only: :create
  skip_before_action :verify_authenticity_token, only: :logout


  # sign in
  def create
    if @user.valid_password?(sign_in_params[:password])
      @user.authentication_token = Devise.friendly_token if @user.authentication_token.blank?
      @user.save!
      
      sign_in "user", @user
      render json: {
        messages: "Signed In Successfully",
        is_success: true,
        data: {user: @user}
      }, status: :ok
    else
      render json: {
        messages: "Signed In Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
    end
  end

  # sign out
  def logout
    token = request.headers["X-User-Token"]
    email = request.headers["X-User-Email"]
    user = User.find_by(email: email, authentication_token: token)
   
    unless user.nil?
      user.authentication_token = nil
      user.save!
    end

    render json: {}, status: :no_content
  end

  private
  def sign_in_params
    params.require(:sign_in).permit :email, :password
  end

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    if @user
      return @user
    else
      render json: {
        messages: "Cannot get User",
        is_success: false,
        data: {}
      }, status: :failure
    end
  end
end
