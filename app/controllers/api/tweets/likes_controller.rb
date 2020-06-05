class Api::Tweets::LikesController < ApiController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :get_tweet
  before_action :get_like, only: [:create, :destroy]

  def index
    render json: @tweet.likes, status: :ok
  end

  def create
    if @like.nil?
      @like = Like.create(user: current_user(), tweet: @tweet)
      render json: @like, status: :created
    else
      return render json: {"error": "the tweet with id #{params[:tweet_id]} was already liked by the current user"}, status: :not_acceptable
    end
  end

  def destroy
    if @like.nil?
      return render json: {"error": "the tweet with id #{params[:tweet_id]} dosen't been liked by the current user"}, status: :not_acceptable
    else
      @like.destroy
      render json: {
        messages: "Like deleted - Success",
      }, status: :ok
    end
  end

  private
  def get_tweet
    @tweet = Tweet.find_by(id: params[:tweet_id])
    return render json: {"error": "the tweet with id #{params[:tweet_id]} doesn't exist"}, status: :unprocessable_entity if @tweet.nil?
  end

  def get_like
    @like = Tweet.find_by(tweet_id: params[:tweet_id], user_id: current_user().id)
  end
end