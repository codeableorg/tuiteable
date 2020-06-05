class UsersController < ApplicationController
  def index
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:alert] ="Success to update your acount"
      redirect_to root_path
    else
      flash[:alert] ="Error to update your acount"
      edit_user_path(@user)
    end
  end

  private 
  def user_params
    params.require(:user).permit(:username, :name, :location, :bio, :avatar)
  end 
end
