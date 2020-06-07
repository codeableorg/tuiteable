# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :name, null: false
      t.string :location
      t.text :bio
      t.integer :followers_count, default: 0
      t.integer :followed_users_count, default: 0
      t.integer :comments_count, default: 0
      t.integer :tuits_count, default: 0

      t.timestamps
    end
  end
end
