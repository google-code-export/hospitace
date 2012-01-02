class Observation < ActiveRecord::Base
  
  TYPES = {
    :reported => 1,
    :floating => 2,
    :unannounced => 3
  }
  
  belongs_to :created_by, :class_name => "User", :foreign_key=>:created_by
  
  has_many :observers
  has_many :users, :through => :observers

  validates_inclusion_of :type, :in => TYPES

end
