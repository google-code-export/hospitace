class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :note
      t.references :people, :limit=>8
      t.references :observation

      t.timestamps
    end
  end
end
