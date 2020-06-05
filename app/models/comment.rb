class Comment < ApplicationRecord
  ## Association
  belongs_to :user
  belongs_to :tweet, counter_cache: true

  ## Validation
  validates :body, presence: true
end
