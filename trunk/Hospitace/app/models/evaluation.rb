class Evaluation < ActiveRecord::Base
  STATES = [:protocol,:verbal_evaluation,:opinion,:final_report]
  
  attr_reader :state
  
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
  
  after_find :load_state
  
  def self.find(id)
      self.includes([:protocol,:verbal_evaluation,:opinion,:final_report]).where(["id = ?", id]).first
  end
  
  def load_state
    STATES.each { |item|  
      res = self.method(item).call() unless item.nil?
      return @state = item if res.nil?
    }
    @state = STATES.last
  end
  
  
end