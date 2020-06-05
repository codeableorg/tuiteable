class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, 
         :omniauthable, omniauth_providers: %i[facebook github]
  has_many :tuits
  has_many :likes
  has_many :comments
  has_many :liked_tuits, through: :likes, source: :tuit
  has_many :commented_tuits, through: :comments, source: :tuit
  has_one_attached :avatar

  # has_many :followers, foreign_key: :follower_id, class_name: "Follow"
  # has_many :followed, through: :followers, source: :followed

  # has_many :followed, foreign_key: :followed_id, class_name: "Follow"
  # has_many :followers, through: :followed, source: :follower

  has_many :follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followed_users, through: :follows, source: :followed

  has_many :followings, foreign_key: :followed_id, class_name: "Follow"
  has_many :followers, through: :followings, source: :follower

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.name.downcase.gsub(/\s/,"") + rand(1..10000).to_s
      user.password = Devise.friendly_token[0, 20]
    end
  end

end
