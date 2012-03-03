class AddEvaluationToForm < ActiveRecord::Migration
  def change
    add_column :forms, :evaluation_id, :integer
    
    add_index :forms, :evaluation_id
  end
end
