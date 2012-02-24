class CreateCourseInstances < ActiveRecord::Migration
  def change
    create_table :course_instances do |t|
      t.integer :capacity
      t.integer :occupied
      t.references :semester
      t.references :course
      t.timestamps
    end
  end
end
