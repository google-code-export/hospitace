class AddUserToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :user_id, :integer
    add_column :attachments, :form_id, :integer
    add_index :attachments, :user_id
    add_index :attachments, :form_id
  end
end
