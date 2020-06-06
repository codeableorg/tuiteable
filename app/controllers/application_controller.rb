class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :email, :location, :bio])
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::NotDefinedError, with: :policy_not_defined

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to "/"
  end

  def policy_not_defined
    flash[:alert] = "There's no policy for this action"
    redirect_to "/"
  end
end
