class Api::SessionsController < Devise::SessionsController
  before_action :sign_in_params, :load_user, only: :create
  skip_before_action :verify_authenticity_token

  def create
    if @user.valid_password?(sign_in_params[:password])
      sign_in :user, @user
      render json: {
        success: true,
        data: { user: @user },
        message: 'Login Successful!',
      }, status: :ok
    else
      render json: {
        success: false,
        data: {},
        message: 'Wrong Password',
      }, status: :unauthorized
    end
  end

  def destroy
    if sign_out :user
      render json: {
        success: true,
        data: {},
      }, status: :ok
    end
  end

  private

  def load_user
    @user = User.find_for_database_authentication(email: sign_in_params[:email])
    unless @user
      render json: {
        success: false,
        data: {},
        message: 'User does not exist',
      }, status: :bad_request
    end
  end

  def sign_in_params
    params.require(:login).permit(%i(email password))
  end
end
