class AddHeadOfDepartment < ActiveRecord::Migration
  def up
    add_column :observations, :head_of_department_id, :integer, :limit=>8
  end

  def down
  end
end
