class UserController < ApplicationController
  def show
    @show_likes = params[:likes]
  end

end
