class RenameColumnNameInUserToTag < ActiveRecord::Migration[6.0]
  def up
    rename_column :users, :name, :tag 
  end
  def down
    rename_column :users, :tag, :name
  end
end
