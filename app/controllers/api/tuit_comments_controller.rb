class Api::TuitCommentsController < ApiController

  before_action :check_user_auth, only: :create

  def tuit_comments
    comments = Tuit.find_by(id: params[:tuit_id]).comments
    render json: comments
  end

  def show_tuit_comment
    comment = Comment.find_by(tuit_id: params[:tuit_id], id: params[:comment_id])
    if comment.nil?
      render json: { message: "Not found" }, status: :not_found
    else
      render json: comment
    end
  end

  def create
    comment = Comment.new(tuit_comment_params)
    comment.user_id = @user.id
    comment.save
    render json: comment, status: :created
  end

  def destroy
    comment = Comment.find_by(tuit_id: params[:tuit_id], id: params[:comment_id])
    comment.destroy
    head :no_content
  end


  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  private

  def tuit_comment_params
    params.permit(:tuit_id, :body)
  end

  def check_user_auth
    token = request.headers["X-User-Token"]
    email = request.headers["X-User-Email"]
    @user = User.find_by(email: email, authentication_token: token)
  end

end