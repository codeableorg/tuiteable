class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:destroy, :new]

    def create
      p "params"
      p comment_params
      @tweet = Tweet.find(params[:tweet_id])
      @comment = @tweet.comments.create(comment_params)
      redirect_to tweet_path(@tweet)
    end

    def destroy
      @tweet = Tweet.find(params[:tweet_id])
      @comment = Comment.find(params[:id])
      @tweet.comments.delete(@comment)
    end
  
    private
    def comment_params
      params.require(:comment).permit(:user_id, :body)
    end
  end
  