class Tuit < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :votes, dependent: :destroy
  has_many :users, through: :votes
  has_many :comments, dependent: :destroy
end
