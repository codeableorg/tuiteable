class Tuit < ApplicationRecord

  before_create do
    self.likes_count = 0
    self.comments_count = 0
  end

  belongs_to :user
  has_many :comments
  has_many :likes

  validates :body, presence: true, length: {minimum: 0, maximum: 280}  
end
