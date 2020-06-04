class TuitsController < ApplicationController
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

  def delete
    @tuit = Tuit.find(tuit_params).destroy
  end
  
  private
  def tuit_params
    params.require(:tuit).permit(:body)
  end
end