class Evaluation < ActiveRecord::Base
  belongs_to :observation
  
  validates :teacher, :presence => true
  validates :room, :presence => true
  validates :date_time, :presence => true
  validates :observation, :presence => true
  
  has_many :attachments
  has_one :protocol
  has_one :verbal_evaluation
  has_one :opinion
  has_one :final_report
  
end