class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order(created_at: :desc)#.includes(user: :avatar_attachment)
  end
  def new
    @tweet=Tweet.new
  end
  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
  end

  def create    
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    if @tweet.save
      redirect_to root_path
    else
      flash[:alert] = "There was a problem creating the tweet"
      redirect_to root_path
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
