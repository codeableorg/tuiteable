class Tweet < ApplicationRecord
  # Relations
  belongs_to :user
  belongs_to :parent, class_name: 'Tweet', optional: true, counter_cache: :responses_count
  has_many :likes, dependent: :destroy
  has_many :users, through: :likes
  has_many :responses, class_name: 'Tweet', foreign_key: 'parent_id', dependent: :destroy
  # Validations
  validates :content, presence: true
end