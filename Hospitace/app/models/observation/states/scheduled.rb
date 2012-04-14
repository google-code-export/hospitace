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