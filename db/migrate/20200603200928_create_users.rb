class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :avatar
      t.string :display_name
      t.boolean :admin
      t.integer :followers_count
      t.integer :followings_count
      t.text :bio
      t.string :location

      t.timestamps
    end
  end
end
