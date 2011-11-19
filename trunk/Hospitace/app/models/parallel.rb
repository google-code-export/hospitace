# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'kosapi'

class Parallel < KOSapi::Parallel
  
  #include KOSapi
  
  def self.find_by_course(code)
    instance = Course.find_by_code(code).instance
    return [] if instance == nil
    
    return instance.parallels
  end
  
  def self.find(course_code,parallel_id)
    parallels = self.find_by_course(course_code)
    parallels.each do |parallel| 
      if parallel.id.to_i == parallel_id  
        return parallel
      end
    end
    return []
  end
  
end
