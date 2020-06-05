class Api::Tweets::CommentsController < ApiController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :get_tweet
  before_action :get_comment, only: [:show, :update, :destroy]

  def index
    render json: @tweet.comments status: :ok
  end

  def show
    render json: @comment, status: :ok
  end

  def create
    @comment = @tweet.comments.build(comment_params)
    @comment.user = current_user()
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @comment
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    render json: {
      messages: "Comment deleted - Success",
    }, status: :ok
  end

  private
  def get_tweet
    @tweet = Tweet.find_by(id: params[:tweet_id])
    return render json: {"error": "the tweet with id #{params[:tweet_id]} doesn't exist"}, status: :unprocessable_entity if @tweet.nil?
  end

  def get_comment
    @comment = Comment.find_by(tweet_id: params[:tweet_id], id: params[:id])
    return render json: {"error" => "The tweet with id #{params[:tweet_id]} doesn't have a comment with id #{params[:id]}"}, status: :unprocessable_entity if @comment.nil?
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end