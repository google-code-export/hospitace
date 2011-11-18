class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :preparation
      t.integer :teacher_calrity_interpretation
      t.integer :teacher_quality_of_interpretation
      t.integer :teacher_communication
      t.integer :teacher_active_participation
      t.integer :teacher_willing_explains
      t.integer :teacher_student_satisfaction
      t.integer :students_readiness
      t.integer :students_independence
      t.integer :students_active
      t.integer :students_teacher_satisfaction

      t.text :comment
      
      t.timestamps
    end
  end
end
