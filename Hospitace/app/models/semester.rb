# To change this template, choose Tools | Templates
# and open the template in the editor.


class Semester < ActiveRecord::Base 
  scope :current_and_next, where("start > DATE(?) or DATE(?) BETWEEN start AND end",Time.zone.now,Time.zone.now)
  
  validates :code, :uniqueness => true
  
  def self.current
    where("DATE(?) BETWEEN start AND end",Time.zone.now).first
  end
  
  def self.used_current_and_next
    find = Observation.group("semester_id").collect {|x| x.semester_id}
    where(:id => find) | current_and_next
  end
  
  has_many :observations
end


#require "kosapi"
#
#class Semester < KOSapi::Semester
#  include KOSapi 
#  
#  def self.find_current_and_next
#    find = self.all.select do |x|
#      return true if self.current_semester.nil?
#      x.id >= self.current_semester.id
#    end
#  end
#  
#  def self.find_used_current_and_next
#    find = Observation.group("semester").collect {|x| x.semester}
#    res = self.all.select do |x|
#      find.include?(x.code)
#    end
#    res | find_current_and_next
#  end
#      
#  def self.current_semester=semester_code
#    semester = Semester.find_by_code(semester_code)
#    @@current_semester = semester;
#  end
#  
#end
