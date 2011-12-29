class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :teacher
      t.string :room
      t.datetime :date_time
      t.references :observation

      t.timestamps
    end
    add_index :evaluations, :observation_id
  end
end
