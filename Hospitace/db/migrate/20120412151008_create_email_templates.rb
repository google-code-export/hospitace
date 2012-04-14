class CreateEmailTemplates < ActiveRecord::Migration
  def change
    create_table :email_templates do |t|
      t.string :subject
      t.text :text
      t.string :form_code

      t.timestamps
    end
  end
end
