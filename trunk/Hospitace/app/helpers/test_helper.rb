module TestHelper
  def dynamic_form(template_id,options = {})
    template = FormTemplate.find template_id
        
    contents = simple_form_for("form",options) do |f|
      content_tag(:filedset) do |tag|
        concat(content_tag(:legend,"#{template.code}) #{template.name}"))            
        concat(content_tag(:p,template.description))
              
        concat(dynamic_inputs(template,f))
            
      end
    end
  end
  
  def dynamic_inputs(template,f)
    entry_templates = template.entry_templates
    
    entry_templates.collect do |et|
      case et.item_type
        when "text"
          f.cktext_area et.id, :toolbar => 'Note', :label => et.label
        when "ranking"
          f.input et.id, :as=>:ranking, :label => et.label
      end
      
    end.join.html_safe
  end
  
  
end
