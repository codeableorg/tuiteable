class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Relationships
  has_many :tweets, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tweets, through: :likes
  # Validations
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :tag, presence: true
  validates :tag, uniqueness: true
  has_many :tweets,  through: :likes
  # Attachments
  has_one_attached :avatar
end
