# To change this template, choose Tools | Templates
# and open the template in the editor.

class Course < KOSapi::Course
  include KOSapi
  
  def self.find(code)
    self.find_by_code(code)
  end
  
  def self.search(search)  
    
    if search  
      data = all
      find = data.select do |x|         
        ((!search[:code].empty?) ? x.code =~ /(?i)#{search[:code]}/ : true)  && 
          ((!search[:name].empty?) ?  x.name =~ /(?i)#{search[:name]}/ : true ) && 
          ((!search[:semester_season].empty?) ? x.semester_season =~ /(?i)#{search[:semester_season]}/ : true )
      end
    else  
      all  
    end 
  end
    
end
  