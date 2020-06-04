class AddParentToGame < ActiveRecord::Migration[6.0]
  def change
    add_reference :tweets, :parent,  foreign_key: {to_table: :tweets}
    rename_column :tweets, :retweet, :retweets_count
  end
end
