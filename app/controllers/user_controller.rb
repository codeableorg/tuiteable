class UserController < ApplicationController
  def profile
    @user = User.first
  end
end
