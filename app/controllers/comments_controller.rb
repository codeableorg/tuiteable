# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    tuit = Tuit.find(params[:tuit_id])
    comment = tuit.comments.new(comment_params)
    comment.user = current_user
    if comment.save
      redirect_to tuit_path(tuit)
    else
      flash[:alert] = 'There was a problem creating your comment'
      redirect_to tuit_path(tuit)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
