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

  def date?
    !(@observation.date > DateTime.now)
  end
  
  def label
    date? ? "warning" : "default"
  end
  
  def short_message
    date? ? "observation.states.scheduled.short" : "observation.states.scheduled.short_wait" 
  end

  def long_message
    long = []
    long << "observation.states.scheduled.long" if date?
  end
  
  def actions
    actions = []
    actions << { :title=>"observation.states.scheduled.actions.evaluation",:href=>"/observations/#{@observation.id}/evaluations/new" } if date?
    return actions
  end
end