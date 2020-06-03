class Comment < ApplicationRecord
  belongs_to :tuit, counter_cache: true
  belongs_to :user
end
