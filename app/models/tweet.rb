class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: "Tweet", optional: true
  has_many :retweets, class_name: "Tweet", foreign_key: "parent_id"
  has_many :likes
  has_many :comments
end
