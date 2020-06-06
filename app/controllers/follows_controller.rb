class FollowsController < ApplicationController
  def create
    @follow = Follow.new(followed_params)
    if @follow.save
      redirect_to user_show_path
    else
      redirect_to user_show_path, alert: 'Something was wrong!'
    end 
  end

  def destroy
  end

  private
  def followed_params
    params.permit(:followed, :follower)
  end

end
