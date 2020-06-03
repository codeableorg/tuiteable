class Tuit < ApplicationRecord
  belongs_to :user
  has_many :comments, :likes
end
