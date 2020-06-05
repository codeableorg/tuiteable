class User < ApplicationRecord

  acts_as_token_authenticatable

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

  ## Authenticate user by email and password
  def self.authenticate(params)
    user = User.find_for_authentication(:email => params["email"])
    user&.valid_password?(params["password"]) ? user : nil
  end

  def reset_authentication_token!
    self.authentication_token = nil
    save # automatically generates a new authentication token
    authentication_token 
  end

  ## Association
  has_many :tweets, foreign_key: :owner_id
  has_many :providers
  has_many :comments
  has_many :commented_tweets, through: :comments, source: :tweet
  has_many :likes, -> { order created_at: :desc }, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_one_attached :avatar

  ## Validation
  validates :username, :email, presence: true, uniqueness: true
  validates :bio, length: { maximum: 160 }
  validates :avatar, file_size: { less_than_or_equal_to: 2.megabyte },
    file_content_type: { allow: ['image/jpeg', 'image/png'] }

end
