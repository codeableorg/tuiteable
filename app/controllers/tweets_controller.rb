class TweetsController < ApplicationController
  before_action :authenticate_user!, only: :destroy

  def destroy
    @tweet = Tweet.find(params[:id])
    authorize @tweet
    @tweet.destroy
    redirect_to tweets_path()
  end
end
