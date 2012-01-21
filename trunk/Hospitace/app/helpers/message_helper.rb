module MessageHelper
  def message(title,text = nil,actions = [],type = "warning")
    content_tag(:div,:class => "alert-message block-message #{type}") do 
      content_tag(:a,"x", :class=>"close", :href=>"#")+
      
      content_tag(:p) do
        content_tag(:strong,title)+" "+text
      end +
      
      content_tag(:div, :class=>"alert-actions") do
        res = actions.collect { |action| alert_action(action[:title],action[:href])}
        res.join(" ").html_safe;
      end

    end
  end
  
  def alert_action(title, href = "#")
    content_tag(:a, title, :class=>"btn small", :href=>href)
  end
end