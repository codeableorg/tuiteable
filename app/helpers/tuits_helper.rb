module TuitsHelper
  def is_liked(tuit)
    tuit.votes.exists?(user: current_user)
  end
end
