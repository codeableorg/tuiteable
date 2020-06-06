# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    tuit = Tuit.find(params[:tuit_id])
    tuit.likes.create!(user: current_user)
    redirect_to tuit_path(tuit)
  end
end
