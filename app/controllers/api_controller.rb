class ApiController < ActionController::API
  acts_as_token_authentication_handler_for User, only: [:create, :destroy]

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end
end
