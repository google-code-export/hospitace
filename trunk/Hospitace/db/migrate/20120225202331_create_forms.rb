class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.references :user
      t.references :form_template
      
      t.timestamps
    end
    add_index :forms, :user_id
    add_index :forms, :form_template_id
  end
end
