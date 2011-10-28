class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :date
      t.text :text
      t.string :entity
      t.integer :entity_id

      t.timestamps
    end
  end
end
