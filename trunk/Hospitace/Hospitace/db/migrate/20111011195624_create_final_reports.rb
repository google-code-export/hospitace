class CreateFinalReports < ActiveRecord::Migration
  def change
    create_table :final_reports do |t|
      t.text :text
      t.timestamp :created
      t.references :observation

      t.timestamps
    end
    add_index :final_reports, :observation_id
  end
end
