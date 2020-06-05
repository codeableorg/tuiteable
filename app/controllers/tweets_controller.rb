class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :create]
  def index
    @tweets = Tweet.all.order(created_at: :desc).limit(40)
    @user = User.new
    @tweet = Tweet.new
  end

  def create 
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else
      render :index
    end
  end 

  def destroy
    @tweet = Tweet.find(params[:id])
    authorize @tweet
    @tweet.destroy
    redirect_to tweets_path()
  end

  private 
  def tweet_params
    params.require(:tweet).permit(:body, :owner_id)
  end 
end
