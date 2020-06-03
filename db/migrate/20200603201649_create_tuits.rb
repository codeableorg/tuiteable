class CreateTuits < ActiveRecord::Migration[6.0]
  def change
    create_table :tuits do |t|
      t.text :body
      t.integer :likes_count
      t.integer :comments_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
