class CreatePeoplesRelateds < ActiveRecord::Migration
  def change
    create_table :peoples_relateds do |t|
#      t.integer :related_id
#      t.string :related_type
      t.references :related, :polymorphic => true
      t.string :relation
      t.references :people
      t.timestamps
    end
  end
end
