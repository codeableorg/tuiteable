class Tuits::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    p tuit = Tuit.find(params[:tuit_id])
    p like = Like.find_by(user: current_user, tuit: tuit)
    p params
    p path = params[:redirect] ? params[:redirect] : tuit_path(tuit)

    if like.nil?
      like = tuit.likes.new(user: current_user)
      if like.save
        redirect_to path
      else
        redirect_to path, alert: 'We could not add your like.'
      end
    else
      redirect_to path, alert: 'You already like this tuit.'
    end
  end

  private
  def like_params
    params.require(:like).permit(:referrer)
  end
end
