class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes  
  has_many :comments
  has_many :tuits
  has_many :liked_tuits, through: :likes
  has_many :commented_tuits, through: :comments

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :username, format: { with: /\A@[a-zA-Z]+\z/,message: "First character should be '@'" }
  validates :email, presence: true, uniqueness: true
  validates :bio, length: {minimum: 0, maximum: 160}
end
