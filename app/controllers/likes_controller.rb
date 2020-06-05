class LikesController < ApplicationController
  before_action :load_tweet, only: [:create, :destroy]
  def create
    if @tweet
      current_user.likes.create(tweet: @tweet)
      redirect_to tweet_path(@tweet)
    else
      flash[:alert] = "Cant not likear"
    end
  end

  def destroy
    if @tweet
      current_user.likes.destroy_by(tweet: @tweet)
      redirect_to tweet_path(@tweet)
    else
      flash[:alert] = "Can not unlikea"
    end
  end

  private
  def load_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end