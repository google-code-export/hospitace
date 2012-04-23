# encoding: utf-8

class MyObservationsController < ApplicationController
  
  helper_method :sort_column, :sort_direction
  
  def observed
    authorize! :observed, Observation
    unless current_user.nil?
      @observations = current_user.observed.includes(:created_by,:observers_people,:course)
    else 
      @observations = []
    end
    
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @observations }
    end
  end
  
  def observing
    authorize! :observing, Observation
    @observations = current_user.observations.includes(:created_by,:observers_people,:course).where(:semester_id=>semester.id).paginate(:page => params[:page]) # Observation.includes(:created_by,:users).where(:semester=>semester.code).paginate(:page => params[:page]) 
    
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @observations }
    end
  end
  
  def manage
    authorize! :m_ob, Observation
    @observations = current_user.created_observations.includes(:created_by,:observers_people,:course).where(:semester_id=>semester.id).paginate(:page => params[:page])
    
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @observations }
    end
  end
  
  def sort_column
    Observation.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
