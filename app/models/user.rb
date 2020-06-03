class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tuits
  has_many :likes
  has_many :comments
  has_many :liked_tuits, through: :likes, source: :tuit
  has_many :commented_tuits, through: :comments, source: :tuit
end
