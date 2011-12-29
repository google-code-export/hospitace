class CreateFinalReports < ActiveRecord::Migration
  def change
    create_table :final_reports do |t|
      t.text :pros
      t.text :cons
      t.text :measures
      t.text :conclusion
      t.references :evaluation

      t.timestamps
    end
    add_index :final_reports, :evaluation_id
  end
end
