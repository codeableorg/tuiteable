class ChangeColumnTweetToBody < ActiveRecord::Migration[6.0]
  def change
    rename_column :tweets, :tweet, :body
  end
end
