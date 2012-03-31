# encoding: utf-8

module ParallelsHelper
  
  def short_parallel(parallel)
    "#{parallel.parallel_type_t}, #{parallel.day_t}, #{l(parallel.start, :format => "%R")} #{parallel.room.code}" unless parallel.nil?
  end
  
  def short_parallel_with_time(parallel)
    "#{parallel.parallel_type_t} #{parallel.day_t}, #{parallel_time(parallel)}" unless parallel.nil?
  end
  
  def parallel_time (parallel)
    "#{l(parallel.start, :format => "%R")} - #{l(parallel.finish, :format => "%R")}"
  end
  
#  def start(parallel)
#    s = AppConfig.start_time + AppConfig.lesson_lenght * (parallel.first_hour-1) + AppConfig.pause_lenght * (parallel.first_hour/2)
#    DateTime.now.change({:hour => s/60 , :min =>(s%60) , :sec => 0 })
#  end
#  
#  def finish(parallel)
#    f = (AppConfig.start_time + AppConfig.lesson_lenght * (parallel.first_hour-1) + AppConfig.pause_lenght * (parallel.first_hour/2)) + AppConfig.lesson_lenght * (parallel.last_hour + 1 - parallel.first_hour) + AppConfig.pause_lenght * ((parallel.last_hour + 1 - parallel.first_hour)/2-1)
#    DateTime.now.change({:hour => f/60 , :min => (f%60) , :sec => 0 })
#  end
    
end
