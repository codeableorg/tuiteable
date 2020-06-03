class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tuit, counter_cache: true
  validates :body, presence: true, length: {minimum: 0, maximum: 280}
end
