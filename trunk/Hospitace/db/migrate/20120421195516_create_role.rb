class CreateRole < ActiveRecord::Migration
  def change
    create_table :role do |t|
      t.integer :roles_mask
      t.reference :people, :limit=>8

      t.timestamps
    end
  end
end
