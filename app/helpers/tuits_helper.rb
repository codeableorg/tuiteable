module TuitsHelper
  def show_avatar(user)
    if user.avatar.attached?
      image_tag(url_for(user.avatar) , alt:"girl" )
    else
     image_tag("girl.jpeg" , alt:"girl" )
    end
  end
end
