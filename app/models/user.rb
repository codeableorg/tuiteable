class User < ApplicationRecord
  has_many :tweets
  has_many :liked_tweets, source: :tweet, through: :likes
  has_many :commented_tweets, source: :tweet, through: :comments
end
