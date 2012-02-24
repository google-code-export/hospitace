class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.primary_key :id
      t.string :email
      t.string :firstname
      t.string :lastname
      t.string :username
      t.string :title_pre
      t.string :title_post
      t.boolean :student
      t.boolean :teacher
      t.timestamps
    end
    execute "alter table people modify column id bigint AUTO_INCREMENT"
  end
end
