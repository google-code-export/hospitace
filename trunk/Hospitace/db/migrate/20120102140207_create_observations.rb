class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.integer :created_by, :limit => 8
      t.references :course
      t.references :semester
      t.references :parallel
      t.date :date
      t.string :observation_type
      t.timestamps
    end
  end
end
