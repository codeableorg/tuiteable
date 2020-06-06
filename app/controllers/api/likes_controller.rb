class Api::LikesController < ApiController
  acts_as_token_authentication_handler_for User, only: [:create, :update]
  before_action :load_tweet, only: [:show, :create, :index]
  def index
    user_likes = @tweet.liked_users.select(:username,:id)
    render json: user_likes, status: :ok
  end

  def create
    like = @tweet.likes.create(user: current_user)
    if like.save
      render json: @tweet, status: :created
    else
      render json: {
          messages: "Didn't create like",
          is_success: false,
          data: {}
      }, status: :unprocessable_entity
    end
  end

  def destroy
    like = Like.find(params[:id])
    p like.user
    p current_user
    if like.user == current_user
      like.destroy!
      render json: @tweet, status: :ok
    else
      render json: {
          messages: "Didn't create like",
          is_success: false,
          data: {}
      }, status: :unauthorized
    end
  end
  private

  def load_tweet
    @tweet = Tweet.find(params[:tuit_id])
  end
end