# encoding: utf-8

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
  
  def actions(options ={})
    options[:class] ||= "unstyled inline pull-right"
    "<ul class=\"#{options[:class]}\">#{yield if block_given?}</ul>".html_safe
  end
  
  def action_icon(title,icon,path,options={},*args)
    return "" if !args.empty? and cannot? *args    
    "<li rel=\"tooltip\" data-original-title=\"#{t(title,:count => 2)}\">
      #{link_to("<i class=\"#{icon}\"></i>".html_safe,path,options) }
    </li>".html_safe
  end
  
  def action_notes(notes,path,options={},*args)
    return "" if !args.empty? and cannot? *args    
    return "" unless notes.count > 0
    "<li rel=\"tooltip\" data-original-title=\"#{t(:notes,:count => notes.count)}\">
      #{link_to("<i class=\"icon-comment\"></i>".html_safe,path,options) }
    </li>".html_safe
  end
end

