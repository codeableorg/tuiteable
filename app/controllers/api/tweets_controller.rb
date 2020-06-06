class Api::TweetsController < ApiController
  def index
    render json: Tweet.all
  end

  def show
    tweet = Tweet.find(params[:id])
    render json: tweet
  end

  def create
    tweet = Tweet.new(tweet_params)
    if tweet.save
      render json: tweet
    else
      render json: tweet.errors
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    render json: { status: 'Successfully destroyed', data: tweet }, status: :ok
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      render json: tweet
    else
      render json: tweet.errors, status: :unprocessable_entity

    end
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  private

  def tweet_params
    params.require(:tweet).permit(:user_id, :content)
  end
end