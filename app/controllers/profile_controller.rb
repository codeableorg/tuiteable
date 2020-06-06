class ProfileController < ApplicationController
  before_action :authenticate_user!
  def tweets
  end

  def liked_tweets
  end
end
