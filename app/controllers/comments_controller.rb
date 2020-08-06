class CommentsController < ApplicationController
  before_action :authenticate_user!, :load_tuit

  def create
    @comment = @tuit.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @tuit
    else
      flash[:alert] = 'Could not create comment'
      redirect_to @tuit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to @tuit
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def load_tuit
    @tuit = Tuit.find(params[:tuit_id])
  end
end
