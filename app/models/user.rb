class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.username = auth.info.name.downcase.gsub(/\s/,"") + rand(1..10000).to_s
    end
  end

  def self.from_omniauth_git(auth)
    p auth
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
    end
  end

end

