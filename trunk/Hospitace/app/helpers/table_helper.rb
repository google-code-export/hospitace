module TableHelper
  
  def th(column,scope=nil,sortable=false)
    title = t(column,:scope=>[scope || "tables.th"])
    direction = "asc"
    css_class = "header"

    if sortable
      if column.to_s == sort_column
        if sort_direction.to_s == "asc"
          direction = "desc"
          css_class += " headerSortDown"
        else
          direction = "asc"
          css_class += " headerSortUp"
        end  
      end
    end  
    
    content_tag(:th,:class=> (sortable ? css_class : "")) do
      next link_to(title, params.merge(:sort => column, :direction => direction, :page => nil)) if sortable
      title
    end
  end
  
  def actions
    "<ul class=\"unstyled inline\">#{yield if block_given?}</ul>".html_safe
  end
  
  def action_icon(title,icon,path,options={},*args)
    return if !args.empty? and cannot? *args    
    "<li rel=\"tooltip\" data-original-title=\"#{t(title)}\">
      #{link_to("<i class=\"#{icon}\"></i>".html_safe,path,options) }
    </li>".html_safe
  end
  
end

