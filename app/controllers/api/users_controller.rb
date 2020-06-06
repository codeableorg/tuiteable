class Api::UsersController < ApiController
  def index
    render json: User.all
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { status: 'Successfully destroyed', data: user }, status: :ok
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  private

  def user_params
    params.require(:user).permit(:email, :tag, :password)
  end
end