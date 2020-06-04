class Api::TweetsController < ApiController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    render json: Tweet.all, status: :ok
  end

  def show
    @tweet = Tweet.find_by(id: params[:id])
    render json: @tweet, status: :ok
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    if @tweet.save
      render json: @tweet, status: :created
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end