class Api::CommentsController < ApiController

    rescue_from ActiveRecord::RecordNotFound do |e|
        render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
        render json: {error: e.message}, status: :unprocessable_entity
    end

    def index

        tweet = Tweet.find(params[:tweet_id])
        comments = tweet.comments
        render json: comments, status: :ok
    end

    def show
      
        tweet = Tweet.find(params[:tweet_id])
        comment = tweet.comments.find(params[:id])
        render json: comment, status: :ok
    end

    def create
        tweet = Tweet.find(params[:tweet_id])
        @comment = tweet.comments.create!(create_params)
        render json: @comment, status: :created
    end

    def destroy
        
        Comment.destroy(params[:id])
        @comments = Comment.all
        render json: @comments, status: :ok
    end

    private
  
    def create_params
      params.require(:tweet).permit(:body, :user_id)
    end
end