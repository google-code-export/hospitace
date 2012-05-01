# To change this template, choose Tools | Templates
# and open the template in the editor.

class Observation::State
  
  
  attr_accessor :observation
  class << self; attr_accessor :next_state, :back_state end
    
  def initialize(observation)
    @observation = observation
  end
    
  def ok?
    false;
  end
  
  def label
    "default"
  end
  
  def next?
    !self.class.next_state.nil? && self.ok?
  end
  
  def next_s
    return unless next?
    @observation.state = self.class.next_state.new @observation
  end
    
  def short_message
    ""
  end
    
  def long_message
    []
  end
    
  def actions
    []
  end
end
  