class Api::TuitsController < ApiController
  before_action :load_tweet, only: [:show]
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
  def index
    @tweets = load_tweets
    render json: @tweets, status: :ok
  end

  def show
    render json: @tweet, status: :ok
  end

  def create
    @tweet =  current_user.tweets.create(tweet_params)
    if @tweet.save
      render json: @tweet, status: :created
    else
      render json: {
          messages: "Didn't create Tuit",
          is_success: false,
          data: {}
      }, status: :unprocessable_entity
    end
  end

  def update
    @tweet =  current_user.tweets.find(params[:id])
    @tweet.update(tweet_params)
    if @tweet.save
      render json: @tweet, status: :ok
    else
      render json: {
          messages: "Didn't update Tuit",
          is_success: false,
          data: {}
      }, status: :unprocessable_entity
    end
  end

  def destroy

    @tweet = current_user.tweets.find(params[:id])
    if @tweet.destroy
      render json: {tweet: @tweet, is_delete: true}, status: :ok
    else
      render json: {
          messages: "Didn't delete Tuit",
          is_success: false,
          data: {}
      }, status: :unprocessable_entity
    end
  end


  private

  def load_tweet
    if params[:user_id]
      @tweet =  User.find(params[:user_id]).tweets.find(params[:id])
    else
      @tweet = Tweet.find(params[:id])
    end
  end
  def load_tweets
    if params[:user_id]
      User.find(params[:user_id]).tweets
    else
      Tweet.all.order(created_at: :desc )
    end
  end
  def tweet_params
    params.require(:tweet).permit(:body)
  end
end