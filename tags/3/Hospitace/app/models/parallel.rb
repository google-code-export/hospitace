# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'kosapi'

class Parallel < ActiveRecord::Base
  include KOSapi::ModelHelpers
  include EmailTemplates::Tagged::ModelHelpers
  
  belongs_to :course_instance
  belongs_to :room
  
  has_many :observations
  
  has_one :course, :through => :course_instance
  has_one :semester, :through => :course_instance
  has_many :peoples_relateds, :as => :related, :class_name => "PeoplesRelated"
  has_many :teachers, :through => :peoples_relateds,:source => :teacher, :conditions => "peoples_relateds.relation = 'teachers'"

  def self.find_by_course_id_and_semester_id(c_id, s_id = nil)
    s_id ||= Semester.current
    i = CourseInstance.find_by_course_id_and_semester_id(c_id,s_id)
    return [] if i.nil?
    i.parallels
  end
  
  def start
    s = AppConfig.start_time + AppConfig.lesson_lenght * (first_hour-1) + AppConfig.pause_lenght * (first_hour/2)
    DateTime.now.change({:hour => s/60 , :min =>(s%60) , :sec => 0 })
  end
  
  def finish
    f = (AppConfig.start_time + AppConfig.lesson_lenght * (first_hour-1) + AppConfig.pause_lenght * (first_hour/2)) + AppConfig.lesson_lenght * (last_hour + 1 - first_hour) + AppConfig.pause_lenght * ((last_hour + 1 - first_hour)/2-1)
    DateTime.now.change({:hour => f/60 , :min => (f%60) , :sec => 0 })
  end
  
  attrs_translate :day, :parallel_type, :parity
  attrs_tagged :number, :parallel_type_t, :day_t
end

