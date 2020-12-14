class Tuits::CommentsController < ApplicationController
  def create
    tuit = Tuit.find(params[:tuit_id])
    comment = tuit.comments.new(comment_params.merge(user: current_user))
    if comment.save
      redirect_to tuit_path(tuit)
    else
      redirect_to tuit_path(tuit), alert: 'We could not create your comment.'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
