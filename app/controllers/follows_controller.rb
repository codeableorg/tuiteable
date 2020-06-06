class FollowsController < ApplicationController
  before_action :load_user, only: [:create, :destroy]
  def create
    if @otherUser
      current_user.followings.create(following_id: @otherUser.id, follower_id: current_user.id)
      redirect_to user_path(@otherUser)
    else
      flash[:alert] = "Can not follow"
    end
  end

  def destroy
    if @otherUser
      current_user.followings.destroy_by(following_id: @otherUser.id)
      redirect_to user_path(@otherUser)
    else
      flash[:alert] = "Can not unfollow"
    end
  end

  private
  def load_user
    @otherUser = User.find(params["user_id"])
  end
end
