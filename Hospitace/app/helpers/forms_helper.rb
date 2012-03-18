module FormsHelper  
  def dynamic_entries(entries,form)
    entries.collect do |en|
      dynamic_entry(en,form) 
    end.join.html_safe
  end
  
  def dynamic_entry(entry,form)
    template = entry.entry_template
    
    case template.item_type
    
    when "text/file"
      "<h3>#{template.label}</h3>
      <p>
        Můžete nahrát naskenovanou část formuláře, nebo vyplnit formulář.
      </p>".html_safe <<
      if entry.persisted?
        "<p><a class=\"btn btn-primary\" href=\"#attachment_modal\" data-toggle=\"modal\"><i class=\"icon-upload icon-white\"></i> Nahrát naskenovaný formulář</a><span id=\"attachment_files\"></span></p>".html_safe
      else
        "<p><a class=\"btn btn-primary disabled\"><i class=\"icon-upload icon-white\"></i> Nahrát naskenovaný formulář</a> Nejprve musíte uložit formulář potom se zpřístupní možnost nahrání souboru.<span id=\"attachment_files\"></span></p>".html_safe
      end <<
        form.cktext_area(template.id, :toolbar => 'Note', :input_html => { :value => entry.value }) 
      
    when "text"
      "<h3>#{template.label}</h3>".html_safe <<
        form.cktext_area(template.id, :toolbar => 'Note', :input_html => { :value => entry.value })
    when "ranking"
      "<tr>
        <td>#{template.label}</td>
        <td></td>
        <td>#{form.radio_button template.id, "A", :checked => (entry.value == "A" ? true : false)}</td>
        <td>#{form.radio_button template.id, "B", :checked => (entry.value == "B" ? true : false)}</td>
        <td>#{form.radio_button template.id, "C", :checked => (entry.value == "C" ? true : false)}</td>
        <td>#{form.radio_button template.id, "D", :checked => (entry.value == "D" ? true : false)}</td>
        <td>#{form.radio_button template.id, "E", :checked => (entry.value == "E" ? true : false)}</td>
        <td>#{form.radio_button template.id, "F", :checked => (entry.value == "F" ? true : false)}</td>
       </tr>"
    when "ranking_table"
      "<table class=\"table table-bordered table-condensed table-striped\">
          <thead>
            <tr>
              <th>#{template.label}</th>
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
            #{dynamic_entries(entry.get_entries,form)}
          </tbody>
        </table>".html_safe
    when "label"
      content_tag(:h3,template.label)
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
      ens = entry.get_entries
      "<table class=\"table table-bordered table-striped\">
          <thead>
            <tr><th colspan=\"#{ens.count}\">#{template.label}</th></tr>
          </thead>
          <tbody>
            <tr>
              #{
                ens.collect do |e|
                "<td>#{e.entry_template.label}</td>"
                end.join.html_safe
              }
            </tr>
            <tr>
              #{
                ens.collect do |e|
                "<td>#{dynamic_entry(e,form)}</td>"
                end.join.html_safe
              }
            </tr>
          </tbody>
        </table>".html_safe
    when "integer"  
      form.input template.id, :as=>:integer, :label => false, :input_html => { :value => entry.value }
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
    when "text/file"
      "<h3>#{entry.label}</h3>
        <p>
          #{link_to("Stáhnout naskenovaný formulář", @attachment, :class=>"btn btn-primary")unless @attachment.nil?}
        </p>
        <div class=\"twipsies well\">#{en.value}</div>".html_safe
    when "text"
      "<h3>#{entry.label}</h3><div class=\"twipsies well\">#{en.value}</div>".html_safe
    when "ranking"
      "<tr>
          <td>#{entry.label}</td>
          <td></td>
          <td>#{en.value == "A" ? "X" : ""}</td>
          <td>#{en.value == "B" ? "X" : ""}</td>
          <td>#{en.value == "C" ? "X" : ""}</td>
          <td>#{en.value == "D" ? "X" : ""}</td>
          <td>#{en.value == "E" ? "X" : ""}</td>
          <td>#{en.value == "F" ? "X" : ""}</td>
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
