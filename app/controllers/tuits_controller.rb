# frozen_string_literal: true

class TuitsController < ApplicationController
  def index
    @tuits = Tuit.all.order(created_at: :desc)
  end

  def show
    @tuit = Tuit.find(params[:id])
  end
end
