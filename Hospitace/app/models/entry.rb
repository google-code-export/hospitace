class Entry < ActiveRecord::Base
  belongs_to :entry_template
  belongs_to :form
  
  validates :entry_template, :presence => true 
  validates :form, :presence => true 
end
