class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :classes_type
      t.string :range
      t.string :semester_season
      t.string :study_form
      t.string :code
      t.string :status
      t.string :completion
      t.string :credits
      t.string :description
      t.string :name
 
      t.timestamps
    end
  end
end
