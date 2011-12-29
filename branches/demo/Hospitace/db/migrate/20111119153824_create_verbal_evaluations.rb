class CreateVerbalEvaluations < ActiveRecord::Migration
  def change
    create_table :verbal_evaluations do |t|
      t.text :verbal
      t.references :evaluation

      t.timestamps
    end
    add_index :verbal_evaluations, :evaluation_id
  end
end
