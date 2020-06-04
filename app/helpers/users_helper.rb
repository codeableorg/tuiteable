module UsersHelper
  def get_avatar(user)
    asset_path user.avatar ? user.avatar : "noimage.png"
  end
end
