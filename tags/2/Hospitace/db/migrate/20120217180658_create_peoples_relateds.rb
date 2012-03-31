class CreatePeoplesRelateds < ActiveRecord::Migration
  def change
    create_table :peoples_relateds do |t|
      t.references :related, :polymorphic => true
      t.string :relation
      t.references :people, :limit=>8
      t.timestamps
    end
  end
end
