class ApiController < ActionController::API
  acts_as_token_authentication_handler_for User, if: :authentication_required?

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
end