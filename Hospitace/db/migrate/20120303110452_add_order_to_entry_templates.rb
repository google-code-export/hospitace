class AddOrderToEntryTemplates < ActiveRecord::Migration
  def change
    add_column :entry_templates, :template_order, :integer
    add_column :entry_templates, :entry_template_id, :integer
    
    add_index :entry_templates, :entry_template_id
  end
end
