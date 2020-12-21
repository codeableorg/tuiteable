class HomeController < ApplicationController
  def index
    @tweets = Tweet.includes(:owner).all.order(created_at: :desc)
    @user = User.new
  end

end
