class HomeController < ApplicationController
  def index
    @tuits = Tuit.all
  end
end
