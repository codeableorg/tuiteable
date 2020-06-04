class ChangeRetweetToTweet < ActiveRecord::Migration[6.0]
  def up
    change_column_default :tweets, :retweets_count, 0
  end
  def down
    change_column_default :tweets, :retweets_count, nil
  end
end
