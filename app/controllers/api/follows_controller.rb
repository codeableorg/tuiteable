class FollowsController < ApiController
  acts_as_token_authentication_handler_for User, only: [:create, :destroy]
  before_action :load_user
  def create
    follow = current_user.followings.create(following: @user)
    if follow.save
      render json: @user, except: [:authentication_token], status: :created
    else
      render json: {
          messages: "You cannot follow this user",
          is_success: false,
          data: {}
      }, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.followings.find_by(user: @user).destroy!
    render json: @user, except: [:authentication_token], status: :ok
  end

  def followers
    followers = @user.followers.select(:username)
    render json: followers, status: :ok
  end

  def followings
    followings = @user.followings.select(:username)
    render json: followings, status: :ok
  end
  private

  def load_user
    @user = User.find(params[:user_id])
  end
end