class Observation < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :presence => true
  validates :paraller, :presence => true
  validates :week, :presence => true
  validates :course, :presence => true
  
  validation_group :step1, :fields=>[:user]
  validation_group :step2, :fields=>[:course]
  validation_group :step3, :fields=>[:paraller,:week]
  validation_group :confirmation, :fields=>:all
  
  has_one :evaluation
  
  
  def self.search(search)  
      scoped  
  end 
  
  def find_course
      Course.find_by_code(course)
  end
  
  def find_parallel
      Parallel.find(course,paraller)   
  end
end
