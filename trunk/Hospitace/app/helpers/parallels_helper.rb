module ParallelsHelper
  
  def short_parallel(parallel)
    "#{parallel.type_t}, #{parallel.day_t}, #{l(start(parallel), :format => "%R")} #{parallel.room.code}" unless parallel.nil?
  end
  
  def parallel_time (parallel)
    "#{l(start(parallel), :format => "%R")} - #{l(finish(parallel), :format => "%R")}"
  end
  
  def start(parallel)
    s = AppConfig.start_time + AppConfig.lesson_lenght * (parallel.first_hour-1) + AppConfig.pause_lenght * (parallel.first_hour/2)
    DateTime.now.change({:hour => s/60 , :min =>(s%60) , :sec => 0 })
  end
  
  def finish(parallel)
    f = (AppConfig.start_time + AppConfig.lesson_lenght * (parallel.first_hour-1) + AppConfig.pause_lenght * (parallel.first_hour/2)) + AppConfig.lesson_lenght * (parallel.last_hour + 1 - parallel.first_hour) + AppConfig.pause_lenght * ((parallel.last_hour + 1 - parallel.first_hour)/2-1)
    DateTime.now.change({:hour => f/60 , :min => (f%60) , :sec => 0 })
  end
    
end
