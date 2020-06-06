class AddParentToTweet < ActiveRecord::Migration[6.0]
  def up
    add_reference :tweets, :parent, index: true
  end

  def down
    remove_reference :tweets, :parent
  end
end