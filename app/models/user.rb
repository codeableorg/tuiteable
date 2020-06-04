class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook github]
  has_many :likes  
  has_many :comments
  has_many :tuits
  has_many :liked_tuits, through: :likes
  has_many :commented_tuits, through: :comments

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :username, format: { with: /\A@[\w]+\z/,message: "First character should be '@'" }
  validates :email, presence: true, uniqueness: true
  validates :bio, length: {maximum: 160}

  def self.from_omniauth(auth)
    p auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.username = "@#{auth.info.name.downcase.gsub(/\s/,'')}#{rand(1..10000).to_s}"
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
