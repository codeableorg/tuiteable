module UsersHelper
  def get_avatar(user)
    avatar = user.avatar
    url = avatar.attached? ? url_for(avatar.variant(resize: "100x100")) : asset_path("noimage.png")
    image_tag url, class: "tweet-useravatar"
  end
end
