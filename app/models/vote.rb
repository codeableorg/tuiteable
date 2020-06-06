class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :tuit, counter_cache: true
end
