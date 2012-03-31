class PeoplesRelated < ActiveRecord::Base
  belongs_to :people
  belongs_to :related, :polymorphic => true
  
  belongs_to :editor, :class_name => "People", :foreign_key=>"people_id"
  belongs_to :examiner, :class_name => "People", :foreign_key=>"people_id"
  belongs_to :guarantor, :class_name => "People", :foreign_key=>"people_id"
  belongs_to :instructor, :class_name => "People", :foreign_key=>"people_id"
  belongs_to :lecturer, :class_name => "People", :foreign_key=>"people_id"
  belongs_to :teacher, :class_name => "People", :foreign_key=>"people_id"
      
  validates_uniqueness_of :people_id, :scope => [:related_id,:related_type, :relation]
end
