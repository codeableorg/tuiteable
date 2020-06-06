module UserHelper
  def show_user_avatar(user)
    if user.avatar.attached?
      image_tag(url_for(user.avatar))
    else
      image_tag("girl.jpeg")
    end
  end
end
