class Tweet < ApplicationRecord
  ## Association
  belongs_to :owner, class_name: 'User'
  has_many :comments, -> { order created_at: :desc }, dependent: :destroy
  has_many :commentators, through: :comments, source: :user
  has_many :likes, -> { order created_at: :desc }, dependent: :destroy
  has_many :likers, through: :likes, source: :user

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
