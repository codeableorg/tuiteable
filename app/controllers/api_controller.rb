class ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: {error: e.message}, status: :bad_request
  end
  rescue_from ActiveRecord::RecordInvalid do |e|
    render json: {error: e.message}, status: :unprocessable_entity
  end
end