class CreateParallels < ActiveRecord::Migration
  def change
    create_table :parallels do |t|
      t.string :day
      t.integer :first_hour
      t.integer :last_hour
      t.string :number
      t.string :parity
      t.string :parallel_type
      t.references :room
      t.references :course_instance
      t.timestamps
    end
  end
end
