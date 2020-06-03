class Tweet < ApplicationRecord
  ## Association
  belongs_to :owner, class_name: 'User'
  has_many :comments
  has_many :commentators, through: :comments, source: :user
  has_and_belongs_to_many :likers, join_table: "likes", class_name: "User",
end
