json.extract! user, :id, :avatar, :tag, :name, :bio, :created_at, :updated_at
json.url user_url(user, format: :json)
