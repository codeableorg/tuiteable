class CreateTuits < ActiveRecord::Migration[6.0]
  def change
    create_table :tuits do |t|
      t.text :body
      t.integer :likes_count
      t.integer :comments_count
      t.integer :tuits_count
      t.references :parent, foreign_key: {to_table: 'tuits'}
      t.references :owner, null: false, foreign_key: {to_table: 'users'}

      t.timestamps
    end
  end
end
