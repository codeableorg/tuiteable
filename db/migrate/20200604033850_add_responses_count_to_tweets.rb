class AddResponsesCountToTweets < ActiveRecord::Migration[6.0]
  def up
    add_column :tweets, :responses_count, :integer, default: 0
  end

  def down
    remove_column :tweets, :responses_count
  end
end
