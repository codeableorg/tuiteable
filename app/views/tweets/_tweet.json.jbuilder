json.extract! tweet, :id, :body, :retweet, :likes, :user_id, :created_at, :updated_at
json.url tweet_url(tweet, format: :json)
