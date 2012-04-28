# To change this template, choose Tools | Templates
# and open the template in the editor.


class Semester < ActiveRecord::Base 
  include EmailTemplatesHelper::Tagged::ModelHelpers
  
  scope :current_and_next, where("start > DATE(?) or DATE(?) BETWEEN start AND end",Time.zone.now,Time.zone.now)
  
  validates :code, :uniqueness => true
  
  def self.current
    where("DATE(?) BETWEEN start AND end",Time.zone.now).first
  end
  
  def self.used_current_and_next
    find = Observation.group("semester_id").collect {|x| x.semester_id}
    where(:id => find) | current_and_next
  end
  
  has_many :observations
  attrs_tagged :code, :name
end