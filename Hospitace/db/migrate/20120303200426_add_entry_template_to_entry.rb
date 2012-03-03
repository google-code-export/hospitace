class AddEntryTemplateToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :entry_template_id, :integer
    
    add_index :entries, :entry_template_id
  end
end
