class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :likes
  has_many :liked_tweets, class_name: "Tweet", through: :likes
  has_many :comments
  has_many :comented_tweets, class_name: "Tweet", through: :comments
  has_many :followers, class_name: "Follow", foreign_key: "following_id"
  has_many :followings, class_name: "Follow", foreign_key: "follower_id"
  has_many :user_followers, through: :followers, source: :follower
  has_many :user_followings, through: :followings, source: :following
end
