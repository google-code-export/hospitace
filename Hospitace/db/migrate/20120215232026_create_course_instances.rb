class CreateCourseInstances < ActiveRecord::Migration
  def change
    create_table :course_instances do |t|

      t.timestamps
    end
  end
end
