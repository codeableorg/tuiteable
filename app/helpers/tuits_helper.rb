module TuitsHelper
  def show_avatar(user, class: '')
    if user.avatar.attached?
      image_tag(url_for(user.avatar), alt: "girl", class: 'show-page__article-image')
    else
      image_tag("girl.jpeg", alt: "girl", class: 'show-page__article-image')
    end
  end
end
