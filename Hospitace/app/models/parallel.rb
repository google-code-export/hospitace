# To change this template, choose Tools | Templates
# and open the template in the editor.

#require 'kosapi'

class Parallel < KOSapi::Parallel
  
  include KOSapi
  
#  def parallel_time 
#    "#{start}-#{finish}"
#  end
#  
#  def start
#    s = AppConfig.start_time + AppConfig.lesson_lenght * (first_hour-1) + AppConfig.pause_lenght * (first_hour/2)
#    "#{s/60}:#{"%02d" % (s%60)}"
#  end 
#  
#  def finish
#    f = (AppConfig.start_time + AppConfig.lesson_lenght * (first_hour-1) + AppConfig.pause_lenght * (first_hour/2)) + AppConfig.lesson_lenght * (last_hour + 1 - first_hour) + AppConfig.pause_lenght * ((last_hour + 1 - first_hour)/2-1)
#    "#{f/60}:#{"%02d" % (f%60)}"
#  end
  
  def self.find_by_course(code)
    instance = Course.find_by_code(code).instance
    return [] if instance == nil
    
    return instance.parallels
  end
   
  def self.find(course_code,parallel_id = nil)
    parallels = self.find_by_course(course_code)
    
    parallels.each do |parallel| 
      if parallel.id.to_i == parallel_id.to_i  
        return parallel
      end
    end
    return Parallel.new({})
  end
  
end
