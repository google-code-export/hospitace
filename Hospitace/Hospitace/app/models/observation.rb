class Observation < ActiveRecord::Base
  
  validates :day,  :presence => true
  validates :announced, :presence => true

  has_one :final_report
  
end
