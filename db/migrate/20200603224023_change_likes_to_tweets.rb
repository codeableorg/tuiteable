class ChangeLikesToTweets < ActiveRecord::Migration[6.0]
  def change
    rename_column :tweets, :likes, :likes_count
  end
end
