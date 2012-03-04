# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'kosapi'

class Parallel < ActiveRecord::Base
  include KOSapi::ModelHelpers
  
  belongs_to :course_instance
  belongs_to :room
  
  has_one :course, :through => :course_instance
  has_one :semester, :through => :course_instance
  has_many :peoples_relateds, :as => :related, :class_name => "PeoplesRelated"
  has_many :teachers, :through => :peoples_relateds,:conditions => "peoples_relateds.relation = 'teachers'"

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
  
#  def self.attrs_with_translate(*args)
##      attr_reader *args 
#      
#      args.each do |attribute|
#        define_method "#{attribute}_t" do
#          value = self.send(attribute)
#          value = value.first if value.is_a?(Array)
#          scope = self.class.name.demodulize.downcase
#          KOSapi::I18n.t value, :scope=>".#{scope}.#{attribute}", :default=>value
#        end
#      end
#  end
  
  attrs_translate :day, :parallel_type, :parity
  
end

#class Parallel < KOSapi::Parallel
#  
#  include KOSapi
#
#  def start
#    s = AppConfig.start_time + AppConfig.lesson_lenght * (first_hour-1) + AppConfig.pause_lenght * (first_hour/2)
#    DateTime.now.change({:hour => s/60 , :min =>(s%60) , :sec => 0 })
#  end
#  
#  def finish
#    f = (AppConfig.start_time + AppConfig.lesson_lenght * (first_hour-1) + AppConfig.pause_lenght * (first_hour/2)) + AppConfig.lesson_lenght * (last_hour + 1 - first_hour) + AppConfig.pause_lenght * ((last_hour + 1 - first_hour)/2-1)
#    DateTime.now.change({:hour => f/60 , :min => (f%60) , :sec => 0 })
#  end
#  
#  def self.find_by_course(code)
#    instance = Course.find_by_code(code).instance
#    return [] if instance == nil
#    
#    return instance.parallels
#  end
#   
#  def self.find(course_code,parallel_id = nil)
#    parallels = self.find_by_course(course_code)
#    
#    parallels.each do |parallel| 
#      if parallel.id.to_i == parallel_id.to_i  
#        return parallel
#      end
#    end
#    return Parallel.new({})
#  end
#  
#end
