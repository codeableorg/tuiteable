class Tuit < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments
  has_many :likers, through: :likes, source: :user
  has_many :commenters, through: :comments, source: :user
end
