# encoding: utf-8

class EmailTemplate < ActiveRecord::Base
  validates :form_code, :presence => true
  validates :subject, :presence => true
  
  def self.events
    coll = FormTemplate.select(:code).group(:code).collect { |e| [:form_template,:created,e.code]  }
  end
    
  private
  
end