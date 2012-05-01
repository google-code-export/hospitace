class Observation::States::Evaluation < Observation::State

  @next_state = Observation::States::Finished
  
  def initialize(observation)
    super observation
  end
  
  def ok?
    check_forms === true
  end

  def check_forms
    self.observation.evaluation.created_all_forms?
  end
  
  def label
    "warning"
  end
  
  def short_message
    short = "observation.states.evaluation.short"
  end

  def long_message
    long = []
    long << {:text=>"observation.states.evaluation.long",:content=>"#{check_forms.name} (#{check_forms.code})"}
  end

  def actions
    actions = []
  end
end