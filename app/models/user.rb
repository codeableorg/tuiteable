class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable, :rememberable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :omniauthable, omniauth_providers: %i[facebook github]

  def self.from_omniauth(auth)
    user = where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.name.downcase.gsub(/\s/,"") + rand(1..10000).to_s
      user.password = Devise.friendly_token[0, 20]
    end

    Provider.where(name: auth.provider, uid: auth.uid, user: user).first_or_create

    user
  end


  ## Association
  has_many :tweets, foreign_key: :owner_id
  has_many :providers
  has_many :comments
  has_many :commented_tweets, through: :comments, source: :tweet
  has_many :liked_tweets, join_table: "likes", class_name: "Tweet"

  ## Validation
  validates :username, :email, presence: true, uniqueness: true

end
