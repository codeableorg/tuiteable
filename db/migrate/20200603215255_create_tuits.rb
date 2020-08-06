class CreateTuits < ActiveRecord::Migration[6.0]
  def change
    create_table :tuits do |t|
      t.text :body
      t.references :owner, null: false, foreign_key: {to_table: :users}
      t.references :parent

      t.timestamps
    end
  end
end
