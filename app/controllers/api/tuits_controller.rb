class Api::TuitsController < ApiController
  before_action :ensure_params_exist, only: :create

  def create
    tuit = Tuit.create(tuit_params)
    if tuit.id.nil?
      render json: tuit.errors.messages, status: :bad_request
    else
      render json: tuit, status: :created
    end
  end

  private

  def tuit_params
    params.require(:tuit).permit(:body, :user_id)
  end

  def ensure_params_exist
    return if params[:tuit].present?
    render json: {
        messages: "Missing Params",
        is_success: false,
        data: {}
      }, status: :bad_request
  end
end