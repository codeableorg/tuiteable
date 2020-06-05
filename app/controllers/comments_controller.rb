class CommentsController < ApplicationController
  def show
    @comment
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(params_comment)
    @comment.tweet_id = params[:tweet_id]
    if @comment.save
      redirect_to tweet_path(params[:tweet_id])
    else
      flash[:alert] = "Can not create comment"
    end
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def params_comment
    params.require(:comment).permit(:body)
  end
end
