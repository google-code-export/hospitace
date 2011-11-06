class AddCourseToObservation < ActiveRecord::Migration
  def change
    add_column :observations, :course, :string
  end
end
