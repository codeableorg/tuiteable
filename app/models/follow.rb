class Follow < ApplicationRecord
  belongs_to :following, class_name: "User", counter_cache
  belongs_to :followers, class_name: "User", counter_cache
end
