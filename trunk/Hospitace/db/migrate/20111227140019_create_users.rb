class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :people, :limit=>8
      t.string :login
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :roles_mask
      t.timestamps
    end
    execute "alter table users modify column id bigint AUTO_INCREMENT"
  end
  
  
end
