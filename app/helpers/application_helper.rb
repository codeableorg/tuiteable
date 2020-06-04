module ApplicationHelper
  def format(date)
    date.strftime("%B %d, %Y")
  end
end
