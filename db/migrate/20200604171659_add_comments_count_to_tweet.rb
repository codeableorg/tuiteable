class AddCommentsCountToTweet < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :comments_count, :integer, null: false, default: 0
  end
end
