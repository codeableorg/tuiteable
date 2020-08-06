class Api::TuitsController < ApiController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:user_id].nil?
      render json: Tuit.all
    else
      render json: Tuit.where(owner_id: params[:user_id])
    end
  end

  def show
    if params[:user_id].nil?
      render json: Tuit.find(params[:id])
    else
      render json: Tuit.find_by(owner_id: params[:user_id], id: params[:id])
    end
  end

  def create
    @tuit = Tuit.new(tuit_params)
    @tuit.owner = current_user
    if @tuit.save
      render json: { success: true, data: @tuit }, status: :ok
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  def update
    @tuit = Tuit.find(params[:id])
    if @tuit.update(tuit_params)
      render json: { success: true, data: @tuit }
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  def destroy
    @tuit = Tuit.find(params[:id])
    @tuit.destroy
    head :no_content
  end

  private

  def tuit_params
    params.require(:tuit).permit(:body)
  end
end
