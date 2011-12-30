# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'kosapi'

class Parallel < KOSapi::Parallel
  
  include KOSapi
  
  
  def parallel_time(parallel) 
    start = AppConfig.start_time + AppConfig.lesson_lenght * (self.first_hour-1) + AppConfig.pause_lenght * (self.first_hour/2)
    finish = start + AppConfig.lesson_lenght * (self.last_hour + 1 - self.first_hour) + AppConfig.pause_lenght * ((self.last_hour + 1 - self.first_hour)/2-1)
    
    start = "#{start/60}:#{"%02d" % (start%60)}"
    finish = "#{finish/60}:#{"%02d" % (finish%60)}"
    "#{start}-#{finish}"
  end
  
  
  
  
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
