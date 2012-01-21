# To change this template, choose Tools | Templates
# and open the template in the editor.

class Observation::States::Scheduled < Observation::State

  @next_state = nil
  
  def initialize(observation)
    super observation
  end
  
  def ok?
    false
  end

  def short_message
    short = :scheduled
  end

  def long_message
    long = []
    long << :scheduled_long
  end

  def actions
    nil?
  end
end
  
#  
#  module Scheduled
#    
#    def self.state_short
#      :scheduled_short
#    end
#    
#    def self.state_long
#      :scheduled_long
#    end
#    
#    def self.state_action
#      nil?
#    end
#    
#  end
#  
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
