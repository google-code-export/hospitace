# encoding: utf-8

module MessageHelper
  def message(title,text = [],actions = [],type = "warning")
    content_tag(:div,:class => "alert alert-block alert-#{type} fade in") do 
      content_tag(:a,"x", :class=>"close", :href=>"#","data-dismiss"=>"alert")+
      
      content_tag(:p) do
        content_tag(:strong,title)+" "+text_content(text)
      end +
      
      content_tag(:div, :class=>"alert-actions") do
        res = actions.collect { |action| alert_action(action[:title],action[:href])}
        res.join(" ").html_safe;
      end

    end
  end
  
  def alert_action(title, href = "#")
    content_tag(:a, t(title), :class=>"btn small", :href=>href)
  end
  
  def text_content(data)
    if data.is_a?(Array)
      text_content = content_tag(:ul) do
        data.collect { |i| 
          if i.is_a? Hash
            content_tag(:li,t(i[:text],:content=>i[:content])) 
          else
            content_tag(:li,t(i)) 
          end
        }.join("").html_safe
      end
    else
      text_content = t(data)
    end
  end
  
  
  def alert_message(text,type="alert")
    "<div class=\"alert alert-#{type} in\">
							<a class=\"close\" href=\"#\" data-dismiss=\"alert\">×</a>
								<strong>#{t(type,:scope=>"message.type")}</strong> #{text} 
		 </div>".html_safe
  end
  
  def label_span(text, type=nil)
    content_tag(:span,text,:class=>"label label-#{type}")
  end

end