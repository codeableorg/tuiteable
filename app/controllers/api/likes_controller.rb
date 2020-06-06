class Api::LikesController < ApiController
  def index
    render json: Like.all
  end

  def create
    like = Like.new(like_params)
    if like.save
      render json: like
    else
      render json: like.errors
    end
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
    render json: { status: 'Successfully destroyed', data: like }, status: :ok

  end

  private

  def like_params
    params.require(:like).permit(:user_id, :tweet_id)
  end
end