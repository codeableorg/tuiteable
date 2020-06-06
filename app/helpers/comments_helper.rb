module CommentsHelper
  def show_user_avatar(user)
    if user.avatar.attached?
      image_tag(url_for(user.avatar), id: "traueaa")
    end
  end
end
