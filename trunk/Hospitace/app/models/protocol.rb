class Protocol < ActiveRecord::Base
  RATING = %w[1 2 3 4 5 6]
  
  validates :evaluation_id,  :presence => true, :uniqueness => true
  
  belongs_to :evaluation
end
