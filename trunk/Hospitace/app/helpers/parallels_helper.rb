module ParallelsHelper
  
  def short_parallel(parallel)
    "#{parallel.day}, #{start(parallel)} #{parallel.room.code}" unless parallel.id.nil?
  end
  
  def parallel_time (parallel)
    "#{start(parallel)}-#{finish(parallel)}"
  end
  
  def start(parallel)
    s = AppConfig.start_time + AppConfig.lesson_lenght * (parallel.first_hour-1) + AppConfig.pause_lenght * (parallel.first_hour/2)
    "#{s/60}:#{"%02d" % (s%60)}"
  end 
  
  def finish(parallel)
    f = (AppConfig.start_time + AppConfig.lesson_lenght * (parallel.first_hour-1) + AppConfig.pause_lenght * (parallel.first_hour/2)) + AppConfig.lesson_lenght * (parallel.last_hour + 1 - parallel.first_hour) + AppConfig.pause_lenght * ((parallel.last_hour + 1 - parallel.first_hour)/2-1)
    "#{f/60}:#{"%02d" % (f%60)}"
  end
  
end
