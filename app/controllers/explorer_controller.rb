class ExplorerController < ApplicationController
  def index
    @tweets = Tweet.all.order(created_at: :desc).first(40)
    @tweet = Tweet.new
    render "home/index"
  end
end
