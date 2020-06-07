class Api::CommentsController < ApiController

  def index
    @comments = Comment.all
  end

end
