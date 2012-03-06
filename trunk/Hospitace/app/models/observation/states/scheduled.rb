# To change this template, choose Tools | Templates
# and open the template in the editor.

class Observation::States::Scheduled < Observation::State

  @next_state = Observation::States::Evaluation
  
  def initialize(observation)
    super observation
  end
  
  def ok?
    (!self.observation.evaluation.nil?)
  end

  def short_message
    short = "observation.states.scheduled.short"
  end

  def long_message
    long = []
    long << "observation.states.scheduled.long"
  end
  
  def actions
    actions = []
  end
end
  
#  module Was
#   
#    def self.state_short
#      :date_short
#    end
#    
#    def self.state_long
#      :date_long
#    end
#    
#    def self.state_action
#      nil?
#    end
#  end
#  
#  module Finished
#    
#    def self.state_short
#      :observer_short
#    end
#    
#    def self.state_long
#      :observer_long
#    end
#    
#    def self.state_action
#      nil?
#    end
#  end
