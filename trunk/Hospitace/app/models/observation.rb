class Observation < ActiveRecord::Base
  
  TYPES = {
    :reported => 1,
    :floating => 2,
    :unannounced => 3
  }
  
  belongs_to :created_by, :class_name => "User", :foreign_key=>:created_by
  
  has_many :observers
  has_many :users, :through => :observers
  has_many :notes

  validates :course, :presence => true
  validates :semester, :presence => true
  
  
  validates :type, :inclusion => {:in => TYPES} 

  #puts TYPES.inspect
  
  def self.search(search)  
    if search  
      scoped
    else  
      scoped  
    end  
  end 
  
end
