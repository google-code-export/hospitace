# encoding: utf-8

class Form < ActiveRecord::Base
  include EmailTemplatesHelper::Tagged::ModelHelpers
  
  belongs_to :evaluation
  belongs_to :user
  belongs_to :form_template
  
  has_one :email_template, :through => :form_template
  
  has_many :entries, :dependent => :destroy
  has_many :attachments, :dependent => :destroy
  
  has_many :root_entries, :class_name => "Entry", :finder_sql => proc { 
      "SELECT e.*
      FROM entries e INNER JOIN entry_templates t ON e.entry_template_id = t.id WHERE e.form_id = #{id} AND t.entry_template_id IS NULL
      ORDER BY t.template_order ASC"
  }
  
  has_many :root_entries_with_new, :class_name => "Entry", :finder_sql => proc { 
      "SELECT * FROM entry_templates t LEFT JOIN (SELECT * FROM entries WHERE form_id = #{id}) as e ON e.entry_template_id = t.id WHERE t.entry_template_id IS NULL AND form_template_id = #{form_template_id}
      ORDER BY t.template_order ASC"
  }
  
  #accepts_nested_attributes_for :entries
  accepts_nested_attributes_for :root_entries
  
  has_one :observation, :through => :evaluation
  has_many :observers, :through => :observation
  
  validates :form_template, :presence => true 
  validates :user, :presence => true 
  validates :evaluation, :presence => true 
  
  
  def get_root_entries
    root_t = form_template.root_entry_templates
    return entries = root_t.collect do |t|
      entry = t.entries.find_by_form_id(id)
      entry = Entry.new(:form_id=>id,:entry_template_id => t.id) if entry.nil?
      entry
    end
  end
  
  def can_create?(observation)
    return false if observation.nil? or form_template.nil? 
  end
  
  def code
    form_template.code
  end
  
  def name
    form_template.name
  end
  
  alias_method :author,:user
  attrs_tagged :code, :name, :author, :created_at
end
