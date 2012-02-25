class ChangeObservationDateToDateTime < ActiveRecord::Migration
  def change
    change_column :observations, :date, :date
  end
end
