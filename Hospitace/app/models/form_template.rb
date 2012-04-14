# encoding: utf-8

class FormTemplate < ActiveRecord::Base
  default_scope :order => 'code ASC'
  
  has_many :entry_templates, :dependent => :destroy
  has_many :root_entry_templates, :class_name => "EntryTemplate", :conditions => {:entry_template_id => nil}, :order => 'template_order ASC'
  
  
  has_many :forms, :dependent => :destroy
  has_many :entries, :through => :form
  
  has_one :email_template, :class_name => "EmailTemplate", :foreign_key => :form_code, :primary_key => :code
  
  def roles=(roles)
    self.roles_mask = self.class.roles(roles)
  end
  
  def role=(role)
    self.roles_mask = roles_mask | 2**User::ROLES.index(role)
  end

  def roles
    User::ROLES.reject do |r|
    ((roles_mask || 0) & 2**User::ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end
end
