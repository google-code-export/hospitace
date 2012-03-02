class FormTemplate < ActiveRecord::Base
  has_many :entry_templates
  has_many :forms
end
