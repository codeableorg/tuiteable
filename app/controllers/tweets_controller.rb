class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :create, :like]
  def index
    @tweets = Tweet.all.order(created_at: :desc).limit(40)
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

  def show
    @tweet = Tweet.find(params[:id])
  end

  def like
    @tweet = Tweet.find(params[:id])
    p @tweet.likers.count
    if current_user.liked_tweets.where(:id => params[:id]).blank?
      @tweet.likers << current_user
    else
      @tweet.likers.delete(current_user)
    end
    redirect_to @tweet
  end

  private 
  def tweet_params
    params.require(:tweet).permit(:body, :owner_id)
  end 
end
