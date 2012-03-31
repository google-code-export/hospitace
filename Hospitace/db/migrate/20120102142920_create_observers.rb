class CreateObservers < ActiveRecord::Migration
  def change
    create_table :observers do |t|
      t.references :user, :limit=>8
      t.references :observation
      t.timestamps
    end
  end
end
