class Follow < ApplicationRecord
  belongs_to :following
  belongs_to :followers
end
