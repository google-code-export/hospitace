require 'will_paginate/array'

class ObservationWizardController < ApplicationController
  helper_method :sort_column, :sort_direction
  
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
  
  def step1
    @users = User.search(params[:search]).paginate(:page => params[:page])
  end
  
  def step2
    @courses = Course.all.paginate(:page => params[:page])
  end
  
  def step3
    @parallels = Parallel.find_by_course(@observation.code).paginate(:page => params[:page])
  end
  
  def confirmation
    
  end
  
  def new
    @users = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page]) 
    session[:observation_params] = {}
    @observation = Observation.new
    
    session[:observation_step] = self.current_step
    respond_to do |format|
      format.html
    end
  end
  
  def create
    #@users = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page]) 
    
    session[:observation_params] = {} unless session[:observation_params] 
    session[:observation_params].deep_merge!(params[:observation]) if params[:observation]
    self.current_step = session[:observation_step] if session[:observation_step]
    
    @observation = Observation.new(session[:observation_params])
    @observation.enable_validation_group self.current_step
    
    
    
    if params[:back_button]
        self.previous_step
    elsif params[:next] || params[:create]    
        if @observation.valid?
          if self.last_step?
            @observation.save
          else 
            self.next_step
          end  
        end  
    end
    session[:observation_step] = self.current_step
    
    respond_to do |format|
      if @observation.persisted?
        self.reset
        format.js
        format.html { redirect_to @observation, notice: 'Observation was successfully created.' }
      else
        format.js
        format.html { render action: "new" }
      end
    end
  end
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
