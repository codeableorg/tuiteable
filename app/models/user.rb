class User < ApplicationRecord
  has_many :tuits
  has_many :likes
  has_many :comments
  has_many :liked_tuits, through: :likes, source: :tuit
  has_many :commented_tuits, through: :comments, source: :tuit
end
