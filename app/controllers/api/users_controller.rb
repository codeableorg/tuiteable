class Api::UsersController < ApiController
  def user_tuits
    tuits = User.find_by(id: params[:user_id]).tuits
    render json: tuits
  end

  def show_user_tuit
    tuit = Tuit.find_by(user_id: params[:user_id], id: params[:id])
    if tuit.nil?
      render json: { message: "Not found" }, status: :not_found
    else
      render json: tuit
    end
  end
end