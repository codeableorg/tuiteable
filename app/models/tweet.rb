class Tweet < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :commentators through: :comments, source: :user

  has_many :likes
  has_many :likers through: :likes, source: :user
end
