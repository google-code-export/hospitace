# To change this template, choose Tools | Templates
# and open the template in the editor.

class Parallel < KOSapi::Parallel
  
  def self.find_by_course(code)
    instance = Course.find_by_code(code).instance
    return [] if instance == nil
    
    return instance.parallels
  end
  
  def self.find(course_code,parallel_id)
    parallels = self.find_by_course(course_code)
    parallels.each do |parallel| 
      return parallel if parallel.id == parallel_id     
    end
    return []
  end
  
end
