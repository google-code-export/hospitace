class CreateEntryTemplates < ActiveRecord::Migration
  def change
    create_table :entry_templates do |t|
      t.references :form_template
      t.boolean :required
      t.string :label
      t.string :default
      t.string :item_type

      t.timestamps
    end
    add_index :entry_templates, :form_template_id
  end
end
