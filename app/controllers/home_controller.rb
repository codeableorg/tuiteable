# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @tuits = Tuit.limit(40).order(created_at: :desc)
    if user_signed_in?
      @user = User.find(current_user.id)
      @ntuit = Tuit.new
    end
    render 'tuits/explorer'
  end

  def signup
    flash[:notice] = 'You must be registered to continue '
    render 'tuits/explorer'
  end
end
