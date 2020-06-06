# frozen_string_literal: true

require 'open-uri'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :email, uniqueness: true
  validates :username, uniqueness: true
  validates :bio, length: { maximum: 500 }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook github]

  has_many :likes, through: :tuits
  has_many :comments, through: :tuits
  has_many :tuits
  has_many :likes
  has_many :comments
  has_one_attached :avatar
  validate :avatar_validation

  def avatar_validation
    if avatar.attached?
      if avatar.blob.byte_size > 1_000_000
        avatar.purge
        errors[:base] << 'Too big'
      elsif !avatar.blob.content_type.starts_with?('image/')
        avatar.purge
        errors[:base] << 'Wrong format'
      end
    end
  end

  def self.from_omniauth(auth)
    downloaded_image = open(auth.info.image)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.location = 'Peru'
      user.email = auth.info.email
      user.bio = auth.info.user_about_me
      user.name = auth.info.name
      user.username = auth.info.name.downcase.gsub(/\s/, '') + rand(1..100).to_s
      user.password = Devise.friendly_token[0, 20]
      user.avatar.attach(io: downloaded_image, filename: 'avatar.jpg', content_type: downloaded_image.content_type)
    end
end
end
