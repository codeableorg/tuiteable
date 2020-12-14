module UserHelper
  def show_user_avatar(user)
    if user.avatar.attached?
      image_tag(url_for(user.avatar), class: 'profile_img')
    else
      image_tag("girl.jpeg", class: 'profile_img')
    end
  end
end
