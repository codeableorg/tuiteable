json.extract! user, :id, :username, :email, :avatar, :display_name, :admin, :followers_count, :followings_count, :bio, :location, :created_at, :updated_at
json.url user_url(user, format: :json)
