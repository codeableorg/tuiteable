class Api::TweetsController < ApiController
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  def index
    render json: Tweet.all, status: :ok
  end

  def show
    @tweet = Tweet.find(params[:id])
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

  def update
    @tweet = Tweet.find(params[:id])
    authorize @tweet
    if @tweet.update(tweet_params)
      render json: @tweet, status: :ok
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    authorize @tweet
    @tweet.destroy
    render json: {
      messages: "Tweet deleted - Success",
    }, status: :ok
  end

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end