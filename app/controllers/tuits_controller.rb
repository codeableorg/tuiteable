class TuitsController < ApplicationController
  def show
    @tuit = Tuit.find(params[:id])
    @comments = @tuit.comments
  end

  def new
    @tuit = Tuit.new
  end
  
  def create
    @tuit = Tuit.new(tuit_params)
    @tuit.user = current_user
    if @tuit.save
      redirect_to "/"
    else
      render :new
    end
  end

  def destroy
    @tuit = Tuit.find(params[:id])
    if @tuit.destroy
      redirect_to "/"
    else
      redirect_to tuit_path, alert: "It's imposible to delete it"
    end
  end

  private
  def tuit_params
    params.require(:tuit).permit(:body, :user)
  end
end
