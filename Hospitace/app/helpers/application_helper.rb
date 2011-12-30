module ApplicationHelper
  
  def title(title)
    @title = title
  end

  def menu_item(title,path,*args)
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

end
