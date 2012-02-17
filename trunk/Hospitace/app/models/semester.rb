# To change this template, choose Tools | Templates
# and open the template in the editor.


class Semester < ActiveRecord::Base
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
