class CreateEntryTemplates < ActiveRecord::Migration
  def change
    create_table :entry_templates do |t|
      t.references :form_template
      t.boolean :required
      t.string :label
      t.string :default
      t.string :item_type
      t.integer :template_order
      t.integer :entry_template_id, :reference=>"entry_template"

      t.timestamps
    end
    add_index :entry_templates, :form_template_id  
    add_index :entry_templates, :entry_template_id
  end
end
