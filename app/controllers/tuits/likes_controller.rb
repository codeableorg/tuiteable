class Tuits::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    tuit = Tuit.find(params[:tuit_id])
    like = Like.find_by(user: current_user, tuit: tuit)
    if like
      redirect_to tuit_path(tuit), alert: 'You already have liked this tuit.'
    elsif tuit.likes.new(user: current_user)&.save
      redirect_to tuit_path(tuit)
    else
      redirect_to tuit_path(tuit), alert: 'We could not add your like.'
    end
  end
end
