module ApplicationHelper
  
  def title(title,options={})
    @title = content_tag(:span,t(title,:scope=>"title.main")<<" ")   
    @title << content_tag(:small,options[:small],nil,false) unless options[:small].nil?
    @title << content_tag(:span,link_to(t(options[:action_title],:scope=>"title.action"),options[:action],:class=>"btn btn-large"),:class=>"action") unless options[:action].nil?
  end

  def menu_item(title,path,*args)
    return if !args.empty? and cannot? *args    
    content_tag(:li,link_to(t(title,:scope=>"menu").html_safe,path), :class => ((current_page?(path) ? "active" : nil )))
  end
  
  def sub_menu(title,*args,&block)
    return if !args.empty? and cannot? *args
    content_tag(:li,:class=>"dropdown","data-dropdown"=>"dropdown") do
      link_to("#{t(title,:scope=>"menu")} <b class=\"caret\"></b>".html_safe, "#",:class=>"dropdown-toggle","data-toggle"=>"dropdown") +
      content_tag(:ul,:class=>"dropdown-menu") do 
        yield if block_given?
      end
    end
  end
  
  def tab_item(title,path,*args)
    return if !args.empty? and cannot? *args
    content_tag(:li,link_to(t(title,:scope=>"tabs").html_safe,path), :class => ((current_page?(path) ? "active" : nil )))
  end

  def show_item(title,value,*args)
    return if !args.empty? and cannot? *args
    content_tag( :dt, title) +  content_tag( :dd, value)
    
#    <dt>Description lists</dt>
#<dd>A description list is perfect for defining terms.</dd>
#    
#    content_tag :div,content_tag(:div,title+":",:class=>"layble")+content_tag(:div,value),:class=>"row show"
  end
  
end
