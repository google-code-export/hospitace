# encoding: utf-8

class FormTemplate < ActiveRecord::Base
  default_scope :order => 'code ASC'
  
  has_many :entry_templates, :dependent => :destroy
  has_many :root_entry_templates, :class_name => "EntryTemplate", :conditions => {:entry_template_id => nil}, :order => 'template_order ASC'
  
  
  has_many :forms, :dependent => :destroy
  has_many :entries, :through => :form
  
  has_one :email_template, :class_name => "EmailTemplate", :foreign_key => :form_code, :primary_key => :code
  
  def count?(evaluation)
    return count == evaluation.forms.where(:form_template_id=>id).size.to_s if count =~ /^[\d]+$/
    evaluation.send(count).size <= evaluation.forms.where(:form_template_id=>id).size
  end
  
  def roles=(roles)
    self.roles_mask = Role.roles(roles)
  end
  
  def role=(role)
    self.roles_mask = roles_mask | 2**Role::ROLES.index(role)
  end

  def roles
    Role::ROLES.reject do |r|
    ((roles_mask || 0) & 2**Role::ROLES.index(r)).zero?
    end
  end

  def create?(role)
    roles.include?(role.to_s)
  end
  
  def user_create?(user,evaluation)
    return false if evaluation.user_role(user).index {|r| create?(r)}.nil?
    return false if count?(evaluation)
    return true if count =~ /^[\d]+$/
    return (evaluation.send(count).where(:id=>user.id).exists? and !evaluation.forms.where(:form_template_id=>id,:people_id=>user.id).exists?)
  end
  
  def readers=(roles)
    self.roles_mask = Role.roles(roles)
  end
  
  def read=(role)
    self.read_mask = read_mask | 2**Role::ROLES.index(role)
  end

  def readers
    Role::ROLES.reject do |r|
    ((read_mask || 0) & 2**Role::ROLES.index(r)).zero?
    end
  end

  def read?(role)
    readers.include?(role.to_s)
  end
  
  def user_read?(user,evaluation)
    return true if read_mask == 0
    return false if evaluation.user_role(user).index {|r| read?(r)}.nil?
    return true
  end
end
