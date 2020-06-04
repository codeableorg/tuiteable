class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :commented_tweets, through: :comments, source: :tweet

  has_many :likes
  has_many :liked_tweets, through: :likes, source: :tweet
end
