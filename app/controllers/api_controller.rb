class ApiController < ActionController::API
  
  # Allow to user_controller to handle token authentication
  acts_as_token_authentication_handler_for User, except: [:logout, :tuit_comments, :show_tuit_comment, :tuit_likes, :index, :show, :show_user_tuit, :user_tuits]
  
end