class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.text :opinion
      t.references :evaluation

      t.timestamps
    end
    add_index :opinions, :evaluation_id
  end
end
