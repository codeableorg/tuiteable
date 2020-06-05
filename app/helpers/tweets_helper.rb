module TweetsHelper
  def print_date_tweet(date)
    date.strftime("%e %B")
  end

  def print_date_time_tweet(datetime)
    datetime.strftime("%l:%M %p - %b %e, %Y")
  end
end
