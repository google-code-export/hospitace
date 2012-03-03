class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.references :observation
      t.string :teacher
      t.string :course
      t.string :guarant
      t.string :room
      t.datetime :datetime_observation

      t.timestamps
    end
  end
end
