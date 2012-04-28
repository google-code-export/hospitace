# encoding: utf-8

require 'kosapi'

class Course < ActiveRecord::Base
  include KOSapi::ModelHelpers
  include EmailTemplatesHelper::Tagged::ModelHelpers
  
  has_many :observations
  has_many :course_instances
  has_many :parallels, :through => :course_instances
  
  validates :code, :uniqueness => true
  
  
  
  def instance(s=nil)
    s ||= Semester.current
    CourseInstance.find_by_course_id_and_semester_id(id,s);
  end
  
  def parallels(s=nil)
    return [] if instance.nil?
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
  
  def to_label
    "#{code} - #{name}"
  end

  
  attrs_translate :classes_type,:completion, :status, :study_form, :semester_season
  attrs_tagged :code, :name
end
  