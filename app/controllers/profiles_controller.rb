# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tuits = @user.tuits
    @likes = @user.likes.map { |like| Tuit.find(like[:tuit_id]) }
  end

  def liked
    @user = User.find(params[:id])
    @likes = @user.likes.map { |like| Tuit.find(like[:tuit_id]) }
    @owner = current_user.id == @user.id if user_signed_in?
    respond_to do |format|
      format.js
    end
  end

  def follow
    @user_to_follow = User.find(params[:id])
    Follow.create!(follower_id: current_user.id, followed_user_id: @user_to_follow.id)
    respond_to do |format|
      format.js
    end
  end

  def unfollow
    @user_to_follow = User.find(params[:id])
    follow = Follow.find_by(follower_id: current_user.id, followed_user_id: @user_to_follow.id)
    Follow.destroy(follow.id)
    respond_to do |format|
      format.js
    end
  end
end
