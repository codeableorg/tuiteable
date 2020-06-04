class Follow < ApplicationRecord
  belongs_to :following, class_name: "User"
  belongs_to :follower, class_name: "User"

  after_create do
    follower.followings_count += 1
    following.followers_count += 1
    follower.save
    following.save
  end
  after_destroy do
   follower.followings_count -= 1
   following.followers_count -= 1
   follower.save
   following.save
  end
end
