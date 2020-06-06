class Api::Tuits::CommentsController < ApiController
  def index
    tuit = Tuit.find(params[:tuit_id])
    render json: tuit.comments, status: :ok
  end

  def show
    tuit = Tuit.find(params[:tuit_id])
    comment = tuit.comments.find(params[:id])
    render json: comment, status: :ok
  end

  def create
    tuit = Tuit.find(params[:tuit_id])
    comment = tuit.comments.new(comment_params.merge(user: current_user))
    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :bad_request
    end
  end

  def destroy
    tuit = Tuit.find(params[:tuit_id])
    comment = tuit.comments.find_by!(id: params[:id], user: current_user)
    comment.destroy
    head :no_content
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
