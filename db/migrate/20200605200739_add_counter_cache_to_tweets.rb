class AddCounterCacheToTweets < ActiveRecord::Migration[6.0]
  def change
    change_table :tweets do |t|
      t.integer :likes_count, default: 0
      t.integer :comments_count, default: 0
    end
  end
end
