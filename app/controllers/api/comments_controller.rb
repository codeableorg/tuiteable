class Api::CommentsController < ApiController
  before_action :load_tuit, :authenticate_user!, only: [:create, :update, :destroy]
  def index
    render json: Comment.where(tuit_id: params[:tuit_id])
  end

  def show
    render json: Comment.find_by!(tuit_id: params[:tuit_id], id: params[:id])
  end

  def create
    @comment = @tuit.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      render json: { success: true, data: @comment }, status: :ok
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  def update
    @comment = @tuit.comments.find(params[:id])
    if @comment.update(comment_params)
      render json: { success: true, data: @comment }
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = @tuit.comments.find(params[:id])
    @comment.destroy
    head :no_content
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def load_tuit
    @tuit = Tuit.find(params[:tuit_id])
  end
end
