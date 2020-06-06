class Api::CommentsController < ApiController
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
  before_action :load_tuit

  def index
    @comments = @tweet.comments
    render json: @comments, status: :ok
  end
  def show
    @comment = @tweet.comments.find(params[:id])
    render json: @comment
  end
  def create
    tweet = @tweet.comments.create(comment_params)
    tweet.user = current_user
    if tweet.save
      render json: tweet, status: :created
    else
      render json: {
          messages: "Didn't create comment",
          is_success: false,
          data: {}
      }, status: :unprocessable_entity
    end
  end

  def update
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: {
          messages: "Didn't update comment",
          is_success: false,
          data: {}
      }, status: :unauthorized
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.destroy
    else
      render json: {
          messages: "Didn't delete comment",
          is_success: false,
          data: {}
      }, status: :unprocessable_entity
    end
  end
  private

  def load_tuit
    @tweet = Tweet.find(params[:tuit_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end