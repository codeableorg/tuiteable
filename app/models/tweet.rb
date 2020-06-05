class Tweet < ApplicationRecord
  attr_accessor :likes

  ## Association
  belongs_to :owner, class_name: 'User'
  has_many :comments, -> { order created_at: :desc }, dependent: :destroy
  has_many :commentators, through: :comments, source: :user
  has_and_belongs_to_many :likers,
    join_table: "likes",
    class_name: "User"

  before_destroy do |tweet| 
    tweet.likers.destroy(tweet.likers) ## Destroy likers and allow callbacks to execute
  end

  ## Validation
  validates :body, presence: true

  ##Callback
  def add_like(liker)
    puts "add like callback"
  end

  def remove_like(liker)
    puts "delete like callback"
  end

end
