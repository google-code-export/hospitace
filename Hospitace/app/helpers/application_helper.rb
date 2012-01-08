module ApplicationHelper
  
  def title(title,options={})
    @title = content_tag(:span,t(title)<<" ")
    @title << content_tag(:small,options[:small]) unless options[:small].nil?
    @title << content_tag(:span,link_to(options[:action_title],options[:action],:class=>"btn large"),:class=>"action") unless options[:action].nil?
    
  end

  def menu_item(title,path,*args)
    return if !args.empty? and cannot? *args    
    content_tag(:li,link_to(t(title),path), :class => ((current_page?(path) ? "active" : nil )))
  end
  
  def tab_item(title,path,*args)
    return if !args.empty? and cannot? *args
    content_tag(:li,link_to(t(title),path), :class => ((current_page?(path) ? "active" : nil )))
  end


  def sortable(column, title = nil)
    title ||= column.titleize  
    
    direction = "asc"
    css_class = "header"
    
    if column.to_s == sort_column
      if sort_direction.to_s == "asc"
        direction = "desc"
        css_class += " headerSortDown"
      else
        direction = "asc"
        css_class += " headerSortUp"
      end  
      
    end
    content_tag(:th,link_to( title, params.merge(:sort => column, :direction => direction, :page => nil)) ,:class=> css_class)
    
  end
  
    
  def parallel_time(parallel) 
    start = AppConfig.start_time + AppConfig.lesson_lenght * (parallel.first_hour-1) + AppConfig.pause_lenght * (parallel.first_hour/2)
    finish = start + AppConfig.lesson_lenght * (parallel.last_hour + 1 - parallel.first_hour) + AppConfig.pause_lenght * ((parallel.last_hour + 1 - parallel.first_hour)/2-1)
    
    start = "#{start/60}:#{"%02d" % (start%60)}"
    finish = "#{finish/60}:#{"%02d" % (finish%60)}"
    "#{start}-#{finish}"
  end

end
