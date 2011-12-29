module ApplicationHelper
  def title(title)
    @title = title
  end
  
  def add_button(title, path)
    @add_button = link_to title, path;
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize  
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil  
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"  
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class} 
  end
  
  def steps_init(data, selected = 0)
    @steps_data = data ||= []
    @steps_selected = selected
  end   
  
  
  
  def parallel_time(parallel) 
    start = AppConfig.start_time + AppConfig.lesson_lenght * (parallel.first_hour-1) + AppConfig.pause_lenght * (parallel.first_hour/2)
    finish = start + AppConfig.lesson_lenght * (parallel.last_hour + 1 - parallel.first_hour) + AppConfig.pause_lenght * ((parallel.last_hour + 1 - parallel.first_hour)/2-1)
    
    start = "#{start/60}:#{"%02d" % (start%60)}"
    finish = "#{finish/60}:#{"%02d" % (finish%60)}"
    "#{start}-#{finish}"
  end
  
end
