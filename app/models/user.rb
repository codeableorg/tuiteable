class User < ApplicationRecord
  has_many :likes, :comments  
  has_many :tuits

  validate :username, :email, presence: true, uniqueness: true
  validate :bio, length: {minimum: 0, maximum: 160}
end
