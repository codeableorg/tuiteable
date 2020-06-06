# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tuit, counter_cache: true

  # validates_uniqueness_of :user_id, scope: :tuit_id, message: "You've already liked it"
end
