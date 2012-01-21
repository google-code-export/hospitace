class AddPeopleIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :people_id, :integer
  end
end
