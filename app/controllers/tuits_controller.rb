class TuitsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :like]

  def index
    @tuits = Tuit.order(:created_at).limit(40)
  end

  def show
    @tuit = Tuit.find(params[:id])
  end

  def create
    @tuit = Tuit.new(tuit_params)
    @tuit.owner = current_user
    if @tuit.save
      redirect_to tuit_path(@tuit)
    else
      redirect_to root_path
    end
  end

  def destroy
    @tuit = Tuit.find(tuit_params).destroy
  end

  def like
    @tuit = Tuit.find(params[:id])
    @vote = @tuit.votes.find_by(user: current_user)
    if @vote
      @vote.destroy
    else
      @tuit.votes.find_or_create_by(user: current_user)
    end
    redirect_to @tuit
  end

  private

  def tuit_params
    params.require(:tuit).permit(:body)
  end
end
