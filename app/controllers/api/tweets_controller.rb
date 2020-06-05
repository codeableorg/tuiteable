class Api::TweetsController < ApiController

  def index
    @tweet = Tweet.all.order(created_at: :desc )
    render json: @tweet, status: :ok
  end
end