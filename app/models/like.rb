# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tuit, counter_cache: true
end
# , dependent: :destroy
