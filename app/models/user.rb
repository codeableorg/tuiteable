class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  devise :omniauthable, omniauth_providers: %i[facebook github]

  has_many :tweets
  has_many :likes
  has_many :liked_tweets, class_name: "Tweet", through: :likes
  has_many :comments
  has_many :comented_tweets, class_name: "Tweet", through: :comments
  has_many :followers, class_name: "Follow", foreign_key: "following_id"
  has_many :followings, class_name: "Follow", foreign_key: "follower_id"
  has_many :user_followers, through: :followers, source: :follower
  has_many :user_followings, through: :followings, source: :following
  has_many :providers

  def self.from_omniauth(auth)
    user = find_or_create_by(email: auth.email) do |user|
      email = auth.info.email
      user.email = if email.nil?
                    "no@mail#{rand(1..10000)}.com"
                  else
                    email
                  end
      user.password = Devise.friendly_token[0, 20]
      user.username = "@" + auth.info.name.downcase.gsub(/\s/,"") + rand(1..10000).to_s
    end

    user.providers.find_or_create_by(provider: auth.provider, uid: auth.uid)
    return user
  end
end
