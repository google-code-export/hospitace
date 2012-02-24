class AddDefaultUsers < ActiveRecord::Migration
  def up
    return unless User.find_by_login("admin").nil?
    u = User.new
    u.login = "admin"
    u.roles_mask = 8
    u.password = "admin"
    u.password_confirmation = "admin"
    u.save!
  end

  def down
  end
end
