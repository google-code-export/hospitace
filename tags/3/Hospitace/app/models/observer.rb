class Observer < ActiveRecord::Base
  
  validates :people,:observation, :presence => true;
  validates :people_id, :uniqueness => { :scope => :observation_id}
  
  belongs_to :observation
  belongs_to :people

end
