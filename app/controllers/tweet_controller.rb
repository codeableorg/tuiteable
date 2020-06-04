class TweetController < ApplicationController
  before_action :authenticate_user!, only: :delete

  def delete
  end
end
