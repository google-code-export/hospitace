class CreateObservers < ActiveRecord::Migration
  def change
    create_table :observers do |t|
      t.references :user
      t.references :observation
      t.timestamps
    end
  end
end
