class LikesController < ApplicationController
  def create
    tweet = Tweet.find(params[:tweet_id])
    tweet.likes.create!(user: current_user)
    redirect_to root_path
  end

  def destroy
    # like = Like.find(params[:id])
    # like.destroy!

    tweet = Tweet.find(params[:tweet_id])
    tweet.likes.destroy!(user: current_user)
    redirect_to root_path
  end
end
