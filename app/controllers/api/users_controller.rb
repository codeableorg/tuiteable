class Api::UsersController < Devise::RegistrationsController
  before_action :ensure_params_exist, only: :create
  skip_before_action :verify_authenticity_token, only: :create

  def create
    user = User.create(user_params)
    if user.save
      render json: {
        success: true,
        data: user,
      }, status: :ok
    else
      render json: {
        success: false,
        data: {},
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(%i(username password name email location bio))
  end

  def ensure_params_exist
    return if params[:user].present?
    render json: {
      success: false,
      message: 'Parameters missing',
    }, status: :bad_request
  end
end
