class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Relationships
  has_many :tweets, dependent: :destroy
  # Validations
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :tag, presence: true
  validates :tag, uniqueness: true
end
