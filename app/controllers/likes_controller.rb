class LikesController < ApplicationController
  before_action :find_tweet
  before_action :find_like, only: [:destroy]
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once."
    else
      @tweet.likes.create(user_id: current_user.id)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Can't unlike."
    else
      @like.destroy
    end
    redirect_back(fallback_location: root_path)
  end

  private
  
  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def find_like
    @like = @tweet.likes.find(params[:id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, tweet_id: params[:tweet_id]).exists?
  end
end
