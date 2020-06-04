class Tweet < ApplicationRecord
  ## Association
  belongs_to :owner, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :commentators, through: :comments, source: :user
  has_and_belongs_to_many :likers,
    join_table: "likes",
    class_name: "User",
    after_add: :add_like,
    after_remove: :remove_like

  before_destroy do |tweet| 
    tweet.likers.destroy(tweet.likers) ## Destroy likers and allow callbacks to execute
  end

  ##Callback
  def add_like(liker)
    puts "Holi desde tweet"
  end

  def remove_like(liker)
    puts "Holi desde tweet"
  end
  
end
