class ApiController < ActionController::API
  
  # Allow to user_controller to handle token authentication
  acts_as_token_authentication_handler_for User, except: [:logout]
  
end