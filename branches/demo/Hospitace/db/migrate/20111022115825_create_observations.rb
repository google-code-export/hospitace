class CreateObservations < ActiveRecord::Migration
  def change
    create_table :observations do |t|
      t.references :user
      t.integer :week
      t.integer :paraller
      t.timestamps
    end
  end
end
