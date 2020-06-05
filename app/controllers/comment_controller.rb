class CommentController < ApplicationController
  def show
    @comment
  end

  def new
    @comment = Comment.new
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end
end
