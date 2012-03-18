class EntryTemplate < ActiveRecord::Base
  default_scope :order => 'template_order ASC'
  scope :root, :conditions => {:entry_template_id => nil}
  
  belongs_to :form_template
  has_many :entries
  
  
  has_many :children, :foreign_key => "entry_template_id", :class_name => "EntryTemplate"
  belongs_to :parent, :foreign_key => "entry_template_id", :class_name => "EntryTemplate"
end
