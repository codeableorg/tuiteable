class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook github]

  has_many :tweets, dependent: :destroy

  has_many :comments, dependent: :destroy
  has_many :commented_tweets, through: :comments, source: :tweet, dependent: :destroy

  has_many :likes , dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet, dependent: :destroy
         
  has_one_attached :avatar

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.username = auth.info.name.downcase.gsub(/\s/,"") + rand(1..10000).to_s
      user.avatar.attach(io: File.open('db/user.png'), filename: 'user.png')
    end
  end

  def self.from_omniauth_git(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      email = auth.info.email
      if email.nil?
        user.email = "email@noemail.com"
      else
        user.email = email
      end
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.username = auth.info.nickname
      user.avatar.attach(io: File.open('db/user.png'), filename: 'user.png')
      
    end
  end

end

