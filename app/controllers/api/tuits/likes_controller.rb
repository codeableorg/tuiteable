class Api::Tuits::LikesController < ApiController
  def index
    tuit = Tuit.find(params[:tuit_id])
    render json: tuit.likes, status: :ok
  end

  def create
    tuit = Tuit.find(params[:tuit_id])
    like = tuit.likes.new(user: current_user)
    if like.save
      render json: like, status: :created
    else
      render json: like.errors, status: :bad_request
    end
  end

  def destroy
    tuit = Tuit.find(params[:tuit_id])
    like = tuit.likes.find_by!(id: params[:id], user: current_user)
    like.destroy
    head :no_content
  end
end
