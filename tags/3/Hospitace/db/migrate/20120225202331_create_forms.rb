class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.references :people, :limit=>8
      t.references :form_template
      t.references :evaluation
      
      t.timestamps
    end
    
    add_index :forms, :evaluation_id
    add_index :forms, :people_id
    add_index :forms, :form_template_id
  end
end
