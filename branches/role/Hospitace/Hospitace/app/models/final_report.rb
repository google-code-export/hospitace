class FinalReport < ActiveRecord::Base
  
  validates :day,  :presence => true
  validates :announced, :presence => true
  
  belongs_to :observation
end
