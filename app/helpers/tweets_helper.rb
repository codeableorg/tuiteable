module TweetsHelper
  def print_date_tweet(date)
    date.strftime("%e %B")
  end

  def print_date_time_tweet(datetime)
    datetime.strftime("%l:%M %p - %b %e, %Y")
  end
  def generate_like(tweet)
    if user_signed_in?
      if current_user.likes.where(tweet_id: tweet.id).first
        content = content_tag(:i , "" ,class: "far fa-heart", style: "color: red")
        link_to content, tweet_like_path(tweet.id), method: :delete, class: "tweetdetail-addlike"
      else
        content = content_tag(:i , "" ,class: "far fa-heart")
        link_to content, tweet_likes_path(tweet.id), method: :post, class: "tweetdetail-addlike"
      end
    else
      content_tag(:i , "" ,class: "far fa-heart")
    end
  end
  def format_time_tweet (date)
    date.strftime("%l:%M - %b %e, %Y")
  end
end
