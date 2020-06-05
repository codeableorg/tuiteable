class Api::Users::TweetsController < ApiController
  before_action :get_user
  before_action :get_tweet, only: [:show]

  def index
    render json: @user.tweets, status: :ok
  end

  def show
    render json: @tweet, status: :ok
  end

  private
  def get_user
    @user = User.find_by(id: params[:user_id])
    return render json: {"error": "the user with id #{params[:user_id]} doesn't exist"}, status: :unprocessable_entity if @user.nil?
  end

  def get_tweet
    @tweet = Tweet.find_by(owner_id: params[:user_id], id: params[:id])
    return render json: {"error" => "The user with id #{params[:user_id]} doesn't have a tweet with id #{params[:id]}"}, status: :unprocessable_entity if @tweet.nil?
  end
end