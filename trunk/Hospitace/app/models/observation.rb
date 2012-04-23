require 'kosapi'

class Observation < ActiveRecord::Base
  include EmailTemplatesHelper::Tagged::ModelHelpers
  TYPES = %w[reported floating unannounced]
  
  attr_accessor :state 
  after_initialize :init_state
  
  belongs_to :created_by, :class_name => "People", :foreign_key=>:created_by
  belongs_to :course
  belongs_to :semester
  belongs_to :parallel
  belongs_to :head_of_department, :class_name => "People", :foreign_key=>:head_of_department_id
  
  has_many :observers, :dependent => :destroy
  has_many :observers_people, :through => :observers, :source => :people
  
  has_many :notes, :dependent => :destroy
  has_one  :evaluation, :dependent => :destroy
  has_many :forms, :through => :evaluation
  
  has_many :teachers, :through => :parallel
  
  validates :course, :presence => true
  validates :semester, :presence => true
  
  validates :observation_type,:presence => true, :inclusion => {:in => TYPES} 
    
  accepts_nested_attributes_for :head_of_department
  
  
  def observed
    teachers.merge(instance.lecturers)
  end
  
  def instance
    CourseInstance.find_by_course_id_and_semester_id(course_id,semester_id) || CourseInstance.new
  end

  def self.search(search)  
    if search  
      scoped
    else  
      scoped  
    end  
  end 
  
  def start
    if(self.parallel) 
      self.parallel.start
    end
  end
  
  def finish
    if(self.parallel) 
      self.parallel.finish
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
