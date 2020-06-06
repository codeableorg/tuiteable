class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.text :bio
      t.string :location
      t.boolean :is_admin

      t.timestamps
    end
  end
end
