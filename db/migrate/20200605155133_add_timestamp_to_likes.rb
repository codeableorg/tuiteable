class AddTimestampToLikes < ActiveRecord::Migration[6.0]
  def change
    change_table :likes do |t|
      t.timestamps
    end
  end
end
