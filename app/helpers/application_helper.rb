module ApplicationHelper
  def format(date)
    date.strftime("%B %d, %Y")
  end

  def heart_img(tuit)
    if current_user && current_user.likes.find_by(tuit: tuit)
      image_tag('red-heart.png')
    else
      image_tag('heart.svg')
    end
  end

  def likes_count(tuit)
    if current_user && current_user.likes.find_by(tuit: tuit)
      render inline: "<span style=\"color:#E0245E\">#{tuit.likes_count}</span>"
    else
      render inline: "<span>#{tuit.likes_count}</span>"
    end
  end
end
