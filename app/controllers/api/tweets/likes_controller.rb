class Api::Tweets::LikesController < ApiController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :get_tweet

  def index
    render json: @tweet.likers status: :ok
  end

  def create
    
  end

  def destroy
    
  end

  private
  def get_tweet
    @tweet = Tweet.find_by(id: params[:tweet_id])
    return render json: {"error": "the tweet with id #{params[:tweet_id]} doesn't exist"}, status: :unprocessable_entity if @tweet.nil?
  end
end