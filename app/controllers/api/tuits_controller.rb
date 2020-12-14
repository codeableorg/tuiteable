class Api::TuitsController < ApiController
  def index
    tuits = Tuit.all
    render json: tuits, status: :ok
  end

  def show
    tuit = Tuit.find(params[:id])
    render json: tuit, status: :ok
  end

  def create
    tuit = Tuit.new(tuit_params.merge(user: current_user))
    if tuit.save
      render json: tuit, status: :created
    else
      render json: game.errors, status: :bad_request
    end
  end

  def destroy
    tuit = Tuit.find_by!(id: params[:id], user: current_user)
    tuit.destroy
    head :no_content
  end

  private
  def tuit_params
    params.require(:tuit).permit(:body)
  end
end
