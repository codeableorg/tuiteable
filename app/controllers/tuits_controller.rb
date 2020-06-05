class TuitsController < ApplicationController
  def show
    @tuit = Tuit.find(params[:id])
    @comments = @tuit.comments.order(created_at: :desc)
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

  private
  def tuit_params
    params.require(:tuit).permit(:body, :user)
  end
end
