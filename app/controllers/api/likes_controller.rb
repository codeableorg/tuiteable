class Api::LikesController < ApiController
  before_action :load_tuit, :authenticate_user!, only: [:create, :destroy]
  def index
    render json: Vote.where(tuit_id: params[:tuit_id])
  end

  def create
    ### TODO: FIX RACE CONDITION
    @vote = @tuit.votes.find_or_create_by(user: current_user)
    render json: { success: true, data: @vote }, status: :ok
  end

  def destroy
    @vote = @tuit.votes.find_by(user: current_user)
    @vote.destroy
    head :no_content
  end

  private

  def load_tuit
    @tuit = Tuit.find(params[:tuit_id])
  end
end
