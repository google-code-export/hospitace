require 'kosapi'

class Observation < ActiveRecord::Base
  #include KOSapi
#  TYPES = {
#    :reported => 1,
#    :floating => 2,
#    :unannounced => 3
#  }
  
  TYPES = %w[reported floating unannounced]
  
  belongs_to :created_by, :class_name => "User", :foreign_key=>:created_by
  
  has_many :observers
  has_many :users, :through => :observers
  has_many :notes

  validates :course, :presence => true
  validates :semester, :presence => true
  
  validates :observation_type,:presence => true, :inclusion => {:in => TYPES} 
  
  def find_course
    c = Course.find(course)
    return Course.new({}) if c.nil?
    return c
  end
  
  def find_parallel
    p = Parallel.find(course,parallel)
  end
    
  def self.search(search)  
    if search  
      scoped
    else  
      scoped  
    end  
  end 
  
end
