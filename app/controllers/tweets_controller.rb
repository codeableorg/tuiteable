class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order(created_at: :desc)#.includes(user: :avatar_attachment)
  end

  def show
    @tweet = Tweet.find(params[:id])
    @comment = Comment.new
  end
end
