class Like < ApplicationRecord
  #Associoations
  belongs_to :user
  belongs_to :tweet, counter_cache: true

  #validations
  validates_uniqueness_of :user_id, scope: :tweet_id, message: "Can't like a tweet more than once"
end
