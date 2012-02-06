class RenameEmail < ActiveRecord::Migration
  def up
    rename_column :users, :email, :login
  end

  def down
    rename_column :users, :login, :email 
  end
end
