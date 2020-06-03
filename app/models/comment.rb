class Comment < ApplicationRecord
  ## Association
  belongs_to :user
  belongs_to :tweet

  ## Validation
  validates :body, presence: true
end
