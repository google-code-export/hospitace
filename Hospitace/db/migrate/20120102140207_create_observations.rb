class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.string :course
      t.string :parallel
      t.date :date
      t.string :observation_type
      t.integer :created_by
      t.timestamps
    end
  end
end
