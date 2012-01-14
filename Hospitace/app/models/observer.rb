class Observer < ActiveRecord::Base
  
  #validates_uniqueness_of :user_id, :scope => :observation_id  
  validates :user,:observation, :presence => true;
  validates :user_id, :uniqueness => { :scope => :observation_id}
  
  belongs_to :observation
  belongs_to :user

end
