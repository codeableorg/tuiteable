class LikesController < ApplicationController
  def create
    tweet = Tweet.find(params[:tweet_id])
    tweet.likes.create!(user: current_user)
    redirect_to root_path
  end

  def destroy
    Like.destroy(params[:id])
    redirect_to root_path
  end
end
