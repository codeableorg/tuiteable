class ChangeFollowersCountToUser < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :followers_count, 0
    change_column_default :users, :followings_count, 0
  end
end
