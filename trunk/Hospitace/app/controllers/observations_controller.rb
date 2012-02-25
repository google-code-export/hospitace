# encoding: utf-8

#require 'will_paginate/array'
class ObservationsController < ApplicationController
  load_and_authorize_resource
  
  helper_method :sort_column, :sort_direction
  
  def date
    @observation = Observation.includes(:created_by,:users,:course).find(params[:id])
    @parallel = @observation.parallel
    
    session[:path] = observation_date_path(@observation)
    session[:parallel] = flash[:parallel] unless flash[:parallel].nil?
    @observation.parallel = session[:parallel] if @observation.parallel.nil?
    
    #@observation.date = @parallel.start
    
    respond_to do |format|
      format.html { render :layout=>"tabs"}
      format.json { render json: @observation }
    end
  end
  
  # GET /observations
  # GET /observations.json
  def index
    @observations = Observation.includes(:created_by,:users,:course).where(:semester_id=>semester.id).where("(`observations`.`observation_type` = 'unannounced' AND `observations`.`created_by` = ?) || `observations`.`observation_type` !='unannounced'",current_user.id).paginate(:page => params[:page]) 
    
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @observations }
    end
  end
  
  # GET /observations/1
  # GET /observations/1.json
  def show
    @observation = Observation.includes(:created_by,:users,:course).find(params[:id])
    @course = @observation.course
    @parallel = @observation.parallel
    respond_to do |format|
      format.html { render :layout=>"tabs" }
      format.json { render json: @observation }
    end
  end

  # GET /observations/new
  # GET /observations/new.json
  def new
    session[:path] = new_observation_path
    @observation = Observation.new
    
    session[:course_id] = flash[:course_id] unless flash[:course_id].nil?
    session[:parallel_id] = flash[:parallel_id] unless flash[:parallel_id].nil?
    
    @observation.course_id ||= session[:course_id]
    @observation.parallel_id ||= session[:parallel_id]
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @observation }
    end
  end

  # GET /observations/1/edit
  def edit
    session[:path] = edit_observation_path(@observation)
    @observation = Observation.find(params[:id])
    @observation.course_id ||= flash[:course_id] unless flash[:course_id].nil?
    @observation.parallel_id ||= flash[:parallel_id] unless flash[:parallel_id].nil?
    
  end

  # POST /observations
  # POST /observations.json
  def create
    @observation = Observation.new(params[:observation])
    @observation.created_by = current_user
    
    respond_to do |format|
      if @observation.save
        format.html { redirect_to @observation, notice: 'Hospitace byla úspěšně vytvořená.' }
        format.json { render json: @observation, status: :created, location: @observation }
      else
        format.html { render action: "new" }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /observations/1
  # PUT /observations/1.json
  def update
    @observation = Observation.find(params[:id])
    puts params[:observation].inspect
    respond_to do |format|
      if @observation.update_attributes(params[:observation])
        format.html { redirect_to @observation, notice: 'Hospitace byla úspěšně upravená.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @observation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /observations/1
  # DELETE /observations/1.json
  def destroy
    @observation = Observation.find(params[:id])
    @observation.destroy

    respond_to do |format|
      format.html { redirect_to observations_url, notice: 'Hospitace byla smazána.' }
      format.json { head :ok }
    end
  end
  
  def sort_column
    Observation.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
