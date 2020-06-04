class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tuit, counter_cache: true
end
