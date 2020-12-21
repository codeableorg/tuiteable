class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::NotDefinedError, with: :policy_not_defined

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :location, :bio, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :location, :bio, :avatar])
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to request.referer
  end

  def policy_not_defined
    flash[:alert] = "There's no policy for this action"
    redirect_to request.referer
  end
end
