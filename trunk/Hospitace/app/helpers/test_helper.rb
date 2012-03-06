module TestHelper
  def dynamic_form(form,options = {})
    template = form.form_template
    entries = template.entry_templates.root
    
    simple_form_for(form,({
          :url=>"/evaluations/#{form.evaluation.id}/forms"
        }.merge(options))
    ) do |f|
      content_tag(:filedset) do
        concat(
          f.input(:form_template_id,:as=>:hidden,:input_html => { :value => template.id })
        )
        concat(
          f.input(:evaluation_id,:as=>:hidden,:input_html => { :value => form.evaluation_id })
        )
        
        concat(content_tag(:legend,"#{template.code}) #{template.name}"))            
        
        concat(content_tag(:p,template.description))
        
        concat(
          f.simple_fields_for(:entries) do |c|
            dynamic_entries(entries,c)
          end
        )
        
        concat(
          content_tag(:div,:class=>"form-actions"){
            f.button :submit, :class => 'btn-primary'
          }
        )    
      end
    end
  end
  
  def dynamic_entries(entries,form)
    entries.collect do |en|
      dynamic_entry(en,form) 
    end.join.html_safe
  end
  
  def dynamic_entry(entry,form)
    case entry.item_type
    when "text"
      "<h3>#{entry.label}</h3>".html_safe <<
        form.cktext_area(entry.id, :toolbar => 'Note')
    when "ranking"
      "<tr>
        <td>#{entry.label}</td>
        <td></td>
        <td>#{form.radio_button entry.id, "A"}</td>
        <td>#{form.radio_button entry.id, "B"}</td>
        <td>#{form.radio_button entry.id, "C"}</td>
        <td>#{form.radio_button entry.id, "D"}</td>
        <td>#{form.radio_button entry.id, "E"}</td>
        <td>#{form.radio_button entry.id, "F"}</td>
       </tr>"
    when "ranking_table"
      "<table class=\"table table-bordered table-condensed table-striped\">
          <thead>
            <tr>
              <th>#{entry.label}</th>
              <th></th>
              <th>A</th>
              <th>B</th>
              <th>C</th>
              <th>D</th>
              <th>E</th>
              <th>F</th>
            </tr>
          </thead>
          <tbody>
            #{dynamic_entries(entry.children,form)}
      </tbody>
        </table>".html_safe
    when "label"
      content_tag(:h3,entry.label)
    when "rating_scale"
      "  <table class=\"table table-bordered\">
  <thead>
    <tr>
      <th colspan=\"6\">Hodnotící stupnice</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>A</td>
      <td>B</td>
      <td>C</td>
      <td>D</td>
      <td>E</td>
      <td>F</td>
    </tr>
    <tr>
      <td>vysoce nad průměrná</td>
      <td>mírně nad průměrná</td>
      <td>průměrná</td>
      <td>mírně pod průměrná</td>
      <td>velmi pod průměrná</td>
      <td>zcela nedostatečná</td>
    </tr>
  </tbody>
</table>".html_safe
    when "column_table"
      ens = entry.children
      "<table class=\"table table-bordered table-striped\">
          <thead>
            <tr><th colspan=\"#{ens.count}\">#{entry.label}</th></tr>
          </thead>
          <tbody>
            <tr>
              #{ens.collect do |e|
      "<td>#{e.label}</td>"
      end.join.html_safe}
            </tr>
            <tr>
              #{ens.collect do |e|
      "<td>#{dynamic_entry(e,form)}</td>"
      end.join.html_safe}
            </tr>
          </tbody>
        </table>".html_safe
    when "integer"  
      form.input entry.id, :as=>:integer, :label => false
    end 
  end
  
  def draw_dynamic_form(form,options = {})
    
    template = form.form_template
    entries = template.entry_templates.root
    
    content_tag(:filedset) do
        
      concat(content_tag(:legend,"#{template.code}) #{template.name}"))            
        
      concat(content_tag(:p,template.description))
        
      concat(draw_dynamic_entries(entries,form))
        
    end
  end
  
  def draw_dynamic_entry(entry,form)
    en = Entry.find_by_entry_template_id_and_form_id(entry.id,form.id)
    en ||= Entry.new
    case entry.item_type
    when "text"
      "<h3>#{entry.label}</h3><div class=\"twipsies well\">#{en.value}</div>".html_safe
    when "ranking"
      "<tr>
          <td>#{entry.label}</td>
          <td></td>
          <td>#{en.value}</td>
         </tr>"
    when "ranking_table"
      "<table class=\"table table-bordered table-condensed table-striped\">
            <thead>
              <tr>
                <th>#{entry.label}</th>
                <th></th>
                <th>Hodnocení</th>
              </tr>
            </thead>
            <tbody>
              #{draw_dynamic_entries(entry.children,form)}
        </tbody>
          </table>".html_safe
    when "label"
      content_tag(:h3,entry.label)
    when "rating_scale"
      "  <table class=\"table table-bordered\">
            <thead>
              <tr>
                <th colspan=\"6\">Hodnotící stupnice</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>A</td>
                <td>B</td>
                <td>C</td>
                <td>D</td>
                <td>E</td>
                <td>F</td>
              </tr>
              <tr>
                <td>vysoce nad průměrná</td>
                <td>mírně nad průměrná</td>
                <td>průměrná</td>
                <td>mírně pod průměrná</td>
                <td>velmi pod průměrná</td>
                <td>zcela nedostatečná</td>
              </tr>
            </tbody>
          </table>".html_safe
    when "column_table"
      ens = entry.children
      "<table class=\"table table-bordered table-striped\">
          <thead>
            <tr><th colspan=\"#{ens.count}\">#{entry.label}</th></tr>
          </thead>
          <tbody>
            <tr>
              #{ens.collect do |e|
      "<td>#{e.label}</td>"
      end.join.html_safe}
            </tr>
            <tr>
              #{ens.collect do |e|
                "<td>#{draw_dynamic_entry(e,form)}</td>"
                end.join.html_safe
               }
            </tr>
          </tbody>
        </table>".html_safe
    when "integer"  
      en.value
    end 
    
    
    
  end
  
  def draw_dynamic_entries(entries,form)
    entries.collect do |en|
      draw_dynamic_entry(en,form) 
    end.join.html_safe
  end
  
end
