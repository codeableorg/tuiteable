class User < ApplicationRecord
  has_many :likes, :comments  
  has_many :tuits

end
