# frozen_string_literal: true

class TuitsController < ApplicationController
  def index
    @tuits = Tuit.all.order(created_at: :desc)
    @tuit = Tuit.new
  end

  def show
    @tuit = Tuit.find(params[:id])
  end

  def create
    @tuit = Tuit.new(tuit_params)
    if @tuit.save
      redirect_to tuit_path(@tuit)
    else
      render 'new'
    end
  end

  def new
    @tuit = Tuit.new
  end

  private

  def tuit_params
    params.require(:tuit).permit(:body)
  end
end
