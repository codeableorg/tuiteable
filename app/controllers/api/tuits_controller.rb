class Api::TuitsController < ApiController
  before_action :check_user_auth, only: :create

  def index
    tuits = Tuit.all
    render json: tuits
  end

  def show
    tuit = Tuit.find_by(id: params[:id])
    if tuit.nil?
      render json: { message: "Not found" }, status: :not_found
    else
      render json: tuit
    end
  end

  def create
    tuit = Tuit.new(tuit_params)
    tuit.user_id = @user.id
    tuit.save
    render json: tuit, status: :created
  end

  def destroy
    comment = Tuit.find_by(id: params[:id])
    comment.destroy
    head :no_content
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  private

  def tuit_params
    params.permit(:body)
  end

  def check_user_auth
    token = request.headers["X-User-Token"]
    email = request.headers["X-User-Email"]
    @user = User.find_by(email: email, authentication_token: token)
  end
end