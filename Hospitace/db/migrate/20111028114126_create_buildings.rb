class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :code
      t.string :description
      t.references :faculty

      t.timestamps
    end
  end
end
