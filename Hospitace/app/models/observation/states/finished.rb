class Observation::States::Finished < Observation::State

  @next_state = nil
  
  def initialize(observation)
    super observation
  end
  
  def ok?
    @observation.forms.order("created_at DESC").first.created_at - DateTime.now < -86400*4
  end

  def label
    "success"
  end
    
  def short_message
    short = "observation.states.finished.short" #planning
  end

  def long_message
    long = []
    #long << "observation.states.finished.long"
  end

  def actions
    actions = []
  end
end