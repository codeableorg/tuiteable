class HomeController < ApplicationController
  def index
    @tuits = Tuit.all.order(created_at: :desc).limit(40)
  end
end
