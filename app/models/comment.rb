class Comment < ApplicationRecord
  belongs_to :user_id
  belongs_to :tuit_id
end
