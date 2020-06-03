class CreateTuits < ActiveRecord::Migration[6.0]
  def change
    create_table :tuits do |t|
      t.text :body
      t.integer :likes_count, default: 0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
