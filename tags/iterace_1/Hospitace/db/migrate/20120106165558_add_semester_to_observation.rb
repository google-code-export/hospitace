class AddSemesterToObservation < ActiveRecord::Migration
  def change
    add_column :observations, :semester, :string
    change_column :observations, :observation_type, :string
  end
end
