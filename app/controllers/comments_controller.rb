class CommentsController < ApplicationController
  def create
    tweet = Tweet.find(params[:tweet_id])
    @comment = tweet.comments.create(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to tweet_path(tweet)
    else
      flash[:alert] = "There was a problem creating the comment"
      redirect_to tweet_path(tweet)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
