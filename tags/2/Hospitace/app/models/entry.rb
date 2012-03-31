class Entry < ActiveRecord::Base
  belongs_to :entry_template
  belongs_to :form
  
  has_many :children_templates, :through => :entry_template, :source=>:children, :order => 'template_order ASC'
  has_many :entries, :class_name => "Entry", :finder_sql => proc { 
      "SELECT e.*
      FROM entries e INNER JOIN entry_templates t ON e.entry_template_id = t.id WHERE e.form_id = #{form_id} AND t.entry_template_id = #{entry_template_id}
      ORDER BY t.template_order ASC"
  }
  
  validates :entry_template, :presence => true 
  validates :form, :presence => true 
  
  accepts_nested_attributes_for :entries
  
  def get_entries
    templates = children_templates
    return entries = templates.collect do |t|
      entry = t.entries.where(:form_id=>form_id).first
      entry = Entry.new(:form_id=>form_id,:entry_template_id => t.id) if entry.nil?
      entry
    end
  end
end
