class Api::LikesController < ApiController

    rescue_from ActiveRecord::RecordNotFound do |e|
        render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
        render json: {error: e.message}, status: :unprocessable_entity
    end

    def index
        tweet = Tweet.find(params[:tweet_id])
        @likes = tweet.likes
        render json: @likes, status: :ok
    end

    def create
        tweet = Tweet.find(params[:tweet_id])
        @like = tweet.likes.create!(create_params)
        render json: @comment, status: :created
    end

    def destroy
        
        Like.destroy(params[:id])
        @likes = Like.all
        render json: @likes, status: :ok
    end

    private
  
    def create_params
      params.require(:like).permit(:user_id)
    end
end