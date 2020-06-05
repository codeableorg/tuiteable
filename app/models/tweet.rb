class Tweet < ApplicationRecord
  ## Association
  belongs_to :owner, class_name: 'User'
  has_many :comments, -> { order created_at: :desc }, dependent: :destroy
  has_many :commentators, through: :comments, source: :user
  has_many :likes, -> { order created_at: :desc }, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  ## Validation
  validates :body, presence: true
end
