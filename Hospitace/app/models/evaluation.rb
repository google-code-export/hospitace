class Evaluation < ActiveRecord::Base
  belongs_to :observation 
  has_many :forms, :dependent => :destroy
  
  validates :observation, :presence => true
  validates :teacher, :presence => true
  validates :course, :presence => true
  validates :guarant, :presence => true
  validates :room, :presence => true
  validates :datetime_observation, :presence => true
end
