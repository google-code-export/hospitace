require 'kosapi'

class Observation < ActiveRecord::Base
  #include KOSapi
#  TYPES = {
#    :reported => 1,
#    :floating => 2,
#    :unannounced => 3
#  }
  
  TYPES = %w[reported floating unannounced]
  
  attr_accessor :state 
  after_initialize :init_state
  
  belongs_to :created_by, :class_name => "User", :foreign_key=>:created_by
  
  has_many :observers, :dependent => :destroy
  has_many :users, :through => :observers
  has_many :notes, :dependent => :destroy

  validates :course, :presence => true
  validates :semester, :presence => true
  
  validates :observation_type,:presence => true, :inclusion => {:in => TYPES} 
  
  def find_course
    c = Course.find(course)
    return Course.new({}) if c.nil?
    c.instance(semester)
    return c
  end
  
  def find_parallel
    return if parallel.empty?
    puts parallel.inspect
    p = Parallel.find(course,parallel)
  end
  
  def find_semester
    return if semester.empty?
    s = Semester.find_by_code(semester)
  end
    
  def self.search(search)  
    if search  
      scoped
    else  
      scoped  
    end  
  end 
  
  
  protected
  
  def init_state
    @state = Observation::States::Create.new(self)
    while (@state.next?) 
      @state.next
    end
  end
  
end
