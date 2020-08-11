class Tweet < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :commentators, through: :comments, source: :user, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user, dependent: :destroy

  def has_liked?(user)
    likes.exists?(user: user)
  end
end
