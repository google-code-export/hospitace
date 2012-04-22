class CreateRole < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :roles_mask
      t.references :people, :limit=>8

      t.timestamps
    end
  end
end
