class AddCountersToTuit < ActiveRecord::Migration[6.0]
  def change
    change_table :tuits do |t|
      t.integer :votes_count, default: 0
      t.integer :comments_count, default: 0
    end
  end
end
