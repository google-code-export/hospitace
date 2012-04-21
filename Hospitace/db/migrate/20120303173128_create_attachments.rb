class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :filename
      t.string :content_type
      t.binary :data, :limit => 10.megabyte
      t.references :people, :limit=>8
      t.references :evaluation
      t.references :form
      
      t.timestamps
    end
    add_index :attachments, :evaluation_id
    add_index :attachments, :people_id
    add_index :attachments, :form_id
  end
end
