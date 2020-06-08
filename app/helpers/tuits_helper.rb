module TuitsHelper
  def is_liked(tuit)
    tuit.votes.exists?(user: current_user)
  end

  def link_to_tuit_owner(tuit)
    link = profile_path(tuit.owner)
    link_to(tuit.owner.username, link, class: 'profile-link')
  end
end
