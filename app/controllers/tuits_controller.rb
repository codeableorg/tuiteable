class TuitsController < ApplicationController
  def show
    @tuit = Tuit.find(params[:id])
    @comments = @tuit.comments
  end
end
