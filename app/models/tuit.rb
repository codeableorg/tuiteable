# frozen_string_literal: true

class Tuit < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :body, presence: true, length: { maximum: 280 }
  def set_user!(user)
    self.user_id = user.id
    save!
  end
end
