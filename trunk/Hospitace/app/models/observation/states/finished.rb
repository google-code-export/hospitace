class Observation::States::Finished < Observation::State

  @next_state = nil
  
  def initialize(observation)
    super observation
  end
  
  def ok?
    true
  end

  def short_message
    short = "observation.states.finished.short" #planning
  end

  def long_message
    long = []
    long << "observation.states.finished.long"
  end

  def actions
    actions = []
  end
end