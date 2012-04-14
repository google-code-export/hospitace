# encoding: utf-8

class EmailTemplate < ActiveRecord::Base
  validates :form_code, :presence => true
  validates :subject, :presence => true
  
  EVENTS = %w[reported floating unannounced]
  
  def self.events
    coll = FormTemplate.select(:code).group(:code).collect { |e| [:form_template,:after,e.code]  }
  end
  
  private
  
  ADDED_EVENTS = [
    [:observation,:after,:created],
    [:observation,:after,:scheduled],
    [:evaluation,:after,:created]
  ]
end
