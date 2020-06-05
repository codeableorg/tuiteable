class Comment < ApplicationRecord
  belongs_to :tuit, counter_cache: true
  belongs_to :user
  # Validations
  validates :body, presence: true, length: { maximum: 280 }
end
