class FinalReport < ActiveRecord::Base
  validates :evaluation_id,  :presence => true, :uniqueness => true
  
  belongs_to :evaluation
end
