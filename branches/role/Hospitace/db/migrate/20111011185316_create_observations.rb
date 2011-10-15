class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.boolean :announced
      t.date :day

      t.timestamps
    end
  end
end
