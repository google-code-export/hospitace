class AddColumnReadMask < ActiveRecord::Migration
  def up
     add_column :form_templates, :read_mask, :integer
  end

  def down
    remove_column :form_templates, :read_mask
  end
end
