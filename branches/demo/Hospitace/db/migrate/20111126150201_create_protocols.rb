class CreateProtocols < ActiveRecord::Migration
  def change
    create_table :protocols do |t|

      t.integer :teacher_preparation
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
      t.text :documentation
      t.references :evaluation
    end
  end
end
