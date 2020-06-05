class FavoritesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @tweets = @user.liked_tweets
  end
end
