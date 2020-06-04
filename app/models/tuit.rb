class Tuit < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likers, through: :likes, source: :user
  has_many :commenters, through: :comments, source: :user
end
