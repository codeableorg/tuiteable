class ChangeLikesCountToTweet < ActiveRecord::Migration[6.0]
  def up
    change_column_default :tweets, :likes_count, 0
  end
  def down
    change_column_default :tweets, :likes_count, nil
  end
end
