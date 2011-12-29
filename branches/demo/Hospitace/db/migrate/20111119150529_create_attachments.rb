class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :filename
      t.string :content_type
      t.binary :data
      t.references :evaluation

      t.timestamps
    end
    add_index :attachments, :evaluation_id
  end
end
