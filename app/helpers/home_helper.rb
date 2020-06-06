module HomeHelper
  def url_active?(text, path)
    active = request.path == path
    url = active ? "#" : path
    html_class = active ? "active" : ""

    link_to(text, url, class: html_class)
  end
end
