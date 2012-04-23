# encoding: utf-8

module FormsHelper  
  def dynamic_entries(entries,form)
    entries.collect do |en|
      dynamic_entry(en,form) do |e,f,o|
        dynamic_entries(e,f) if e.is_a?(Array)
      end
    end.join.html_safe
  end
  
  
  def d_text_file(entry,form,options={})
    d_text(entry,form,options) do |e,f,o|
      "<p>
        Můžete nahrát naskenovanou část formuláře, nebo vyplnit formulář.
      </p>".html_safe <<
        if entry.persisted?
        "<p><a class=\"btn btn-primary\" href=\"#attachment_modal\" data-toggle=\"modal\"><i class=\"icon-upload icon-white\"></i> Nahrát naskenovaný formulář</a><span id=\"attachment_files\"></span></p>".html_safe
      else
        "<p><a class=\"btn btn-primary disabled\"><i class=\"icon-upload icon-white\"></i> Nahrát naskenovaný formulář</a> Nejprve musíte uložit formulář potom se zpřístupní možnost nahrání souboru.<span id=\"attachment_files\"></span></p>".html_safe
      end
    end
  end
  
  def d_text(entry,form,options={})
    template = entry.entry_template
    out = "<h3>#{template.label}</h3>".html_safe 
    out << yield(entry,form,options) if block_given?
    out << form.cktext_area(template.id, :toolbar => 'Note',:namespace=>"test", :input_html => { :value => entry.value })
  end 
  
  def d_ranking(entry,form,options={})
    template = entry.entry_template
    "<tr>
        <td>#{template.label}</td>
        <td></td>
        <td>#{form.radio_button template.id, "A", :checked => (entry.value == "A" ? true : false)}</td>
        <td>#{form.radio_button template.id, "B", :checked => (entry.value == "B" ? true : false)}</td>
        <td>#{form.radio_button template.id, "C", :checked => (entry.value == "C" ? true : false)}</td>
        <td>#{form.radio_button template.id, "D", :checked => (entry.value == "D" ? true : false)}</td>
        <td>#{form.radio_button template.id, "E", :checked => (entry.value == "E" ? true : false)}</td>
        <td>#{form.radio_button template.id, "F", :checked => (entry.value == "F" ? true : false)}</td>
        <td>#{yield entry.get_entries,form,options if block_given?}</td>
       </tr>"
  end
  
  def d_note(entry,form,options={})
    template = entry.entry_template
    form.text_field( template.id, :value => entry.value,:style=>((entry.value.nil? or entry.value == "") ? "display:none" : ""))<<
      " <a class=\"field_note open #{((entry.value.nil? or entry.value == "") ? "" : "hide")}\" href=\"#\"><i class=\"icon-pencil\"></i></a> 
      <a class=\"field_note dis #{((entry.value.nil? or entry.value == "") ? "hide" : "")}\" href=\"#\"><i class=\"icon-ban-circle\"></i></a>".html_safe
  end
  
  def d_ranking_table(entry,form,options={})
    template = entry.entry_template
    "<table class=\"table table-bordered table-condensed table-striped\">
          <colgroup>
                <col width=\"40%\" />
                <col width=\"1%\" />
                <col width=\"5%\" />
                <col width=\"5%\" />
                <col width=\"5%\" />
                <col width=\"5%\" />
                <col width=\"5%\" />
                <col width=\"5%\" />
            </colgroup>
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
              <th>Poznámky</th>
            </tr>
          </thead>
          <tbody>
            #{yield entry.get_entries,form,options if block_given?}
          </tbody>
        </table>".html_safe
  end
  
  def d_label(entry,form,options={})
    template = entry.entry_template
    content_tag(:h3,template.label)
  end
  
  def d_rating_scale(entry,form,options={})
    "<table class=\"table table-bordered\">
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
  end
  
  def d_column_table(entry,form,options={})
    template = entry.entry_template
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
  end
  
  def d_integer(entry,form,options={})
    template = entry.entry_template
    form.input template.id, :as=>:integer, :label => false, :input_html => { :value => entry.value }
  end
  
  def dynamic_entry(entry,form)
    template = entry.entry_template
    case template.item_type
    when "text/file"
      d_text_file(entry,form) { |e,f,o| yield e,f,o}
    when "text"
      d_text(entry,form) { |e,f,o| yield e,f,o}
    when "ranking"
      d_ranking(entry,form) { |e,f,o| yield e,f,o}
    when "ranking_table"
      d_ranking_table(entry,form) { |e,f,o| yield e,f,o}
    when "label"
      d_label(entry,form) { |e,f,o| yield e,f,o}
    when "rating_scale"
      d_rating_scale(entry,form) { |e,f,o| yield e,f,o}
    when "column_table"
      d_column_table(entry,form) { |e,f,o| yield e,f,o}
    when "integer"
      d_integer(entry,form) { |e,f,o| yield e,f,o}
    when "note"
      d_note(entry,form) { |e,f,o| yield e,f,o}
    end  
  end
  
  def d_draw_text_file(entry,form,options={})
    d_draw_text(entry,form,options) do |e,f,o|
      "<p>
          #{link_to("Stáhnout naskenovaný formulář", @attachment, :class=>"btn btn-primary")unless @attachment.nil?}
        </p>"
    end
  end
  
  def d_draw_text(entry,form,options={})
    template = entry.entry_template
    "<h3>#{template.label}</h3>#{yield(entry,form,options) if block_given?}<div class=\"twipsies well\">#{entry.value}</div>".html_safe
  end 
  
  def d_draw_note(entry,form,options={})
    entry.value
  end
  
  def d_draw_ranking(entry,form,options={})
    "<tr>
          <td>#{entry.entry_template.label}</td>
          <td></td>
          <td>#{entry.value == "A" ? "X" : ""}</td>
          <td>#{entry.value == "B" ? "X" : ""}</td>
          <td>#{entry.value == "C" ? "X" : ""}</td>
          <td>#{entry.value == "D" ? "X" : ""}</td>
          <td>#{entry.value == "E" ? "X" : ""}</td>
          <td>#{entry.value == "F" ? "X" : ""}</td>
          <td>#{yield entry.get_entries,form,options if block_given?}</td>
         </tr>"
  end
  
  def d_draw_ranking_table(entry,form,options={})
    "<table class=\"table table-bordered table-condensed table-striped\">
            <colgroup>
                <col width=\"40%\" />
                <col width=\"1%\" />
                <col width=\"5%\" />
                <col width=\"5%\" />
                <col width=\"5%\" />
                <col width=\"5%\" />
                <col width=\"5%\" />
                <col width=\"5%\" />
            </colgroup>
            <thead>
              <tr>
                <th>#{entry.entry_template.label}</th>
                <th></th>
                <th>A</th>
                <th>B</th>
                <th>C</th>
                <th>D</th>
                <th>E</th>
                <th>F</th>
                <th>Poznámky</th>
              </tr>
            </thead>
            <tbody>
              #{yield entry.get_entries,form,options if block_given?}
        </tbody>
          </table>".html_safe
  end
   
  alias :d_draw_label :d_label
  alias :d_draw_rating_scale :d_rating_scale
  
  def d_draw_column_table(entry,form,options={})
    template = entry.entry_template
    ens = entry.get_entries
    "<table class=\"table table-bordered table-striped\">
          <thead>
            <tr><th colspan=\"#{ens.count}\">#{template.label}</th></tr>
          </thead>
          <tbody>
            <tr>
              #{ens.collect do |e|
    "<td>#{e.entry_template.label}</td>"
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
  end
  
  def d_draw_integer(entry,form,options={}) 
    entry.value
  end
  
  def draw_dynamic_entry(entry,form)   
    template = entry.entry_template
    case template.item_type
    when "text/file"
      d_draw_text_file(entry,form) { |e,f,o| yield e,f,o}
    when "text"
      d_draw_text(entry,form) { |e,f,o| yield e,f,o}
    when "ranking"
      d_draw_ranking(entry,form) { |e,f,o| yield e,f,o}
    when "ranking_table"
      d_draw_ranking_table(entry,form) { |e,f,o| yield e,f,o}
    when "label"
      d_draw_label(entry,form) { |e,f,o| yield e,f,o}
    when "rating_scale"
      d_draw_rating_scale(entry,form) { |e,f,o| yield e,f,o}
    when "column_table"
      d_draw_column_table(entry,form) { |e,f,o| yield e,f,o}
    when "integer"
      d_draw_integer(entry,form) { |e,f,o| yield e,f,o}
    when "note"
      d_draw_note(entry,form) { |e,f,o| yield e,f,o}
    end  
  end
  
  def draw_dynamic_entries(entries,form)
    entries.collect do |en|
      draw_dynamic_entry(en,form) do |e,f,o|
        draw_dynamic_entries(e,f) if e.is_a?(Array)
      end
    end.join.html_safe
  end
  
  
  def form_tab(template,evaluation,*args,&block)
    form = template.forms.where(:evaluation_id => evaluation).first
    if template.user_create?(current_user, evaluation)
      form ||= Form.new({
          :form_template=>template,
          :evaluation=>evaluation
        })
      
      return tab_item("#{template.code}_new","/evaluations/#{evaluation.id}/forms/new/#{template.code}",:create,form)
    elsif !form.nil?
      return tab_item("#{template.code}","/evaluations/#{evaluation.id}/forms/code/#{template.code}",:read, form)
    end  
        
  end
end




#<% FormTemplate.all.each do |template| %>
#      <% 
#      forms = template.forms.where(:evaluation_id =#> @evaluation.id)
#
#      unless forms.any? 
#        form = Form.new({
#            :form_template=>template,
#            :evaluation=>@evaluation
#          }) 
#      %>
#
#        <%= tab_item("#{template.code}_new","/evaluations/#{@evaluation.id}/forms/new/#{template.code}") if can? :create, form %#>
#      <% else %>
#        <% form = template.forms.where({:evaluation_id=>@evaluation.id}).first %>
#
#        <%= 
#        if @evaluation.form?(template.code) and can?(:create, form)
#          tab_item("#{template.code}","/evaluations/#{@evaluation.id}/forms/code/#{template.code}") if can? :read, form 
#        else 
#          tab_item("#{template.code}_new","/evaluations/#{@evaluation.id}/forms/new/#{template.code}") if can? :create, form 
#        end
#      %#>
#      <% end %>
#    <% end %>
