class TweetsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy, :like]

  def index
    @tweets = Tweet.all
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
end
