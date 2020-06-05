class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def show_likes
    @user = current_user
  end
end
