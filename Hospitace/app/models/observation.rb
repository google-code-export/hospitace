require 'kosapi'

class Observation < ActiveRecord::Base
 
  TYPES = %w[reported floating unannounced]
  
  attr_accessor :state 
  after_initialize :init_state
  
  belongs_to :created_by, :class_name => "User", :foreign_key=>:created_by
  belongs_to :course
  belongs_to :semester
  belongs_to :parallel
  
  has_many :observers, :dependent => :destroy
  has_many :users, :through => :observers
  has_many :notes, :dependent => :destroy
  has_one  :evaluation, :dependent => :destroy

  validates :course, :presence => true
  validates :semester, :presence => true
  
  validates :observation_type,:presence => true, :inclusion => {:in => TYPES} 
    
  def instance
    CourseInstance.find_by_course_id_and_semester_id(course_id,semester_id)
  end
  
#  def find_parallel
#    return if parallel.nil?
#    p = Parallel.find(course,parallel)
#  end
  
#  def find_semester
#    return if semester.empty?
#    s = Semester.find_by_code(semester)
#  end
    
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
      @state.next_s
    end
  end
  
end
