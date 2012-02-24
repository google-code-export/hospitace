class AddSemesterToObservation < ActiveRecord::Migration
  def change
    change_column :observations, :observation_type, :string
  end
end
