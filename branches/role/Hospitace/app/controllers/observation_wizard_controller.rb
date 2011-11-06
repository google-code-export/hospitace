class ObservationWizardController < ApplicationController

  
  attr_writer :current_step
  
  def current_step
    @current_step || steps.first
  end
  
  def steps
    [:step1, :step2, :step3, :confirmation ]
  end
  
  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end
  
  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def first_step?
    current_step == steps.first
  end

  def last_step?
    current_step == steps.last
  end
  
  def reset
    session[:observation_step] = session[:observation_params] = nil
  end
  
  def new
    session[:observation_params] = {}
    @observation = Observation.new
    
    session[:observation_step] = self.current_step
    respond_to do |format|
      format.html
    end
  end
  
  def create
    session[:observation_params] = {} unless session[:observation_params] 
    session[:observation_params].deep_merge!(params[:observation]) if params[:observation]
    self.current_step = session[:observation_step] if session[:observation_step]
    
    @observation = Observation.new(session[:observation_params])
    @observation.enable_validation_group self.current_step
    
    if @observation.valid?
      if params[:back_button]
        self.previous_step
      elsif self.last_step?
        @observation.save
      else
        self.next_step
      end  
      session[:observation_step] = self.current_step
    end
    
    respond_to do |format|
      if false#@observation.persisted?
        self.reset
        format.html { redirect_to @observation, notice: 'Observation was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end
  
end
