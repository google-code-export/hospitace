class CreateFormTemplates < ActiveRecord::Migration
  def change
    create_table :form_templates do |t|
      t.string :code
      t.string :name
      t.text :description
      t.boolean :required
      t.string :count
      t.integer :roles_mask

      t.timestamps
    end
  end
end
