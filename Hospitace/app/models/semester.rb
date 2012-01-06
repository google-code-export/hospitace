# To change this template, choose Tools | Templates
# and open the template in the editor.

class Semester < KOSapi::Semester
  include KOSapi 
  
  def self.find_current_and_next
    find = self.all.select do |x|
      return true if self.current_semester.nil?
      x.id >= self.current_semester.id
    end
  end
  
end
