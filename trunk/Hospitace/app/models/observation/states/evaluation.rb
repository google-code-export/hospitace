class Observation::States::Evaluation < Observation::State

  @next_state = Observation::States::Finished
  
  def initialize(observation)
    super observation
  end
  
  def ok?
    (self.observation.evaluation.forms.joins(:form_template).where("form_templates.code = 'A'").any?) and
    (self.observation.evaluation.forms.joins(:form_template).where("form_templates.code = 'B'").any?) and 
    (self.observation.evaluation.forms.joins(:form_template).where("form_templates.code = 'C'").any?) and 
    (self.observation.evaluation.forms.joins(:form_template).where("form_templates.code = 'D'").any?)  
  end

  def short_message
    short = "observation.states.evaluation.short" #planning
  end

  def long_message
    long = []
    long << "observation.states.evaluation.long"
  end

  def actions
    actions = []
  end
end