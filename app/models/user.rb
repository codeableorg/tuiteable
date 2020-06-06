class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(facebook github)

  has_many :tuits, foreign_key: 'owner_id', dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :liked_tuits, source: 'tuit', through: :votes
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  acts_as_token_authenticatable

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.name.downcase.gsub(/\s/, "") + rand(1..10000).to_s
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
