class CreateProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :providers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :uid

      t.timestamps
    end
  end
end
