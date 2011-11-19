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
  
end
