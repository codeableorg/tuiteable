class Api::TuitLikesController < ApiController

  before_action :check_user_auth, only: :create

  def tuit_likes
    likes = Tuit.find_by(id: params[:tuit_id]).likes
    render json: likes
  end

  def create
    like = Like.new(tuit_like_params)
    like.user_id = @user.id
    like.save
    render json: like, status: :created
  end

  def destroy
    like = Like.find_by(tuit_id: params[:tuit_id], id: params[:like_id])
    like.destroy
    head :no_content
  end


  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  private

  def tuit_like_params
    params.permit(:tuit_id)
  end

  def check_user_auth
    token = request.headers["X-User-Token"]
    email = request.headers["X-User-Email"]
    @user = User.find_by(email: email, authentication_token: token)
  end
  
end