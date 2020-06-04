class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :location
      t.text :bio
      t.boolean :is_admin

      t.timestamps
    end
  end
end
