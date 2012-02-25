class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.text :value
      t.references :entry
      t.references :form

      t.timestamps
    end
    add_index :entries, :entry_id
    add_index :entries, :form_id
  end
end
