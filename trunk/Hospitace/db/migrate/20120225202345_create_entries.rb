class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :value
      t.references :entry
      t.references :form
      t.references :entry_template
      t.timestamps
    end
    
    add_index :entries, :entry_template_id
    add_index :entries, :entry_id
    add_index :entries, :form_id
  end
end
