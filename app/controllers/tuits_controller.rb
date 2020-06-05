class TuitsController < ApplicationController
  def index
    @tuits = Tuit.all
  end
end
