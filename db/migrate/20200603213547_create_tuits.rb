class CreateTuits < ActiveRecord::Migration[6.0]
  def change
    create_table :tuits do |t|
      t.text :body, null: false
      t.integer :likes_count, null: false, default: 0
      t.integer :comments_count, null: false, default: 0
      t.integer :tuits_count, null: false, default: 0
      t.references :parent, foreign_key: {to_table: 'tuits'}
      t.references :owner, null: false, foreign_key: {to_table: 'users'}

      t.timestamps
    end
  end
end
