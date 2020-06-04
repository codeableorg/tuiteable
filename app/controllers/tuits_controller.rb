class TuitsController < ApplicationController
  def index
  end

  def show
    @tuit = Tuit.find(params[:id])
    # @vote = Vote.find_by(user: current_user, meme: @meme)
  end

  def new
    @tuit = Tuit.new
  end

  def edit
  end

  def create
    @tuit = Tuit.new(tuit_params)
    @tuit.owner = current_user
    if @tuit.save
      redirect_to tuit_path(@tuit)
    else
      render :new
    end
  end

  def update
  end

  def delete
  end
end
