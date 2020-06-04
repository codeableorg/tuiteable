class Api::TweetsController < ApiController
  def index
    render json: Tweet.all, status: :ok
  end
end