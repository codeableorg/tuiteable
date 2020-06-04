class ApplicationController < ActionController::Base

  include Pundit

  def index
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::NotDefinedError, with: :policy_not_defined

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to root_path
  end
  def policy_not_defined
    flash[:alert] = "There's no policy for this action"
    redirect_to root_path
  end
end
