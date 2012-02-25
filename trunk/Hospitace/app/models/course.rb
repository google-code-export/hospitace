# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'kosapi'

class Course < ActiveRecord::Base
  include KOSapi::ModelHelpers
  
  has_many :observations
  has_many :course_instances
  has_many :parallels, :through => :course_instances
  
  validates :code, :uniqueness => true
  
  
  
  def instance(s=nil)
    s ||= Semester.current
    CourseInstance.find_by_course_id_and_semester_id(id,s);
  end
  
  def parallels(s=nil)
    instance.parallels
  end
  
  def self.search(search)  
    if search  
      query,data = [],[]
      
      search.each do |key,value|  
        next if value == "" or value == 0 

        query <<  " #{key} LIKE ?"
        data << "%#{value}%"
      end 
      where(query.join(' AND'),*data)
    else  
      scoped  
    end
  end 
  
  attrs_translate :classes_type,:completion, :status, :study_form, :semester_season
end
  