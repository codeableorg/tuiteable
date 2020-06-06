class Api::TweetsController < ApiController

    rescue_from ActiveRecord::RecordNotFound do |e|
        render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
        render json: {error: e.message}, status: :unprocessable_entity
    end

    def index
        if params[:user_id]
            user = User.find(params[:user_id])
            tweets = user.tweets
        else
            tweets = Tweet.all
        end
        render json: tweets, status: :ok
    end

    def show
        if params[:user_id]
            user = User.find(params[:user_id])
            tweet = user.tweets.find(params[:id])
        else
            tweet = Tweet.find(params[:id])
        end
        render json: tweet, status: :ok
    end

    def create
        @tweet = Tweet.create!(create_params)
        render json: @tweet, status: :created
    end

    def destroy
        Tweet.destroy(params[:id])
        @tweet = Tweet.all
        render json: @tweet, status: :ok
    end

    private
  
    def create_params
      params.require(:tweet).permit(:body, :user_id)
    end
end