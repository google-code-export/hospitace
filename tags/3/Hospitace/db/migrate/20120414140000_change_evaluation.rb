class ChangeEvaluation < ActiveRecord::Migration
  def up
    rename_column :evaluations,:teacher,:teacher_id
    change_column :evaluations,:teacher_id,:integer, :limit=>8
    
    rename_column :evaluations,:guarant,:guarant_id
    change_column :evaluations,:guarant_id,:integer, :limit=>8
  end
  
  def down
  end

end
