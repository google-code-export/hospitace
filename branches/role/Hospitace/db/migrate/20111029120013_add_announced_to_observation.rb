class AddAnnouncedToObservation < ActiveRecord::Migration
  def change
    add_column :observations, :announced, :boolean
  end
end
