class Api::Users::TuitsController < ApiController
  def index
    user = User.find(params[:user_id])
    render json: user.tuits, status: :ok
  end

  def show
    user = User.find(params[:user_id])
    tuit = user.tuits.find(params[:id])
    render json: tuit, status: :ok
  end
end
