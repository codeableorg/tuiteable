class ApiController < ActionController::API
  acts_as_token_authentication_handler_for User, if: :authentication_required?

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::NotDefinedError, with: :policy_not_defined

  def authentication_required?
    authentication_callback.present? &&
      authentication_callback
        .instance_variable_get('@if')
        .all? { |callable| callable.call(self) } &&
      authentication_callback
        .instance_variable_get('@unless')
        .none? { |callable| callable.call(self) }
  end

  def authentication_callback
    @authentication_callback ||= _process_action_callbacks.find do |callback|
      callback.instance_variable_get('@key') == :authenticate_user!
    end
  end

  private
  def user_not_authorized
    render json: {
      messages: "Signed In Failed - Unauthorized",
    }, status: :unauthorized
  end

  def policy_not_defined
    render json: {
      messages: "Signed In Failed - Unauthorized",
    }, status: :unauthorized
  end
end