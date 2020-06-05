module UsersHelper
  def get_avatar(user)
    avatar = user.avatar
    avatar.attached? ? url_for(avatar) : asset_path("noimage.png")
  end
  def format_date_profile(date)
    date.strftime("%b  %Y")
  end
end
