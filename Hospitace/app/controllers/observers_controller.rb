# encoding: utf-8

class ObserversController < ApplicationController
  load_and_authorize_resource
  
  helper_method :sort_column, :sort_direction
  
  # GET /users
  # GET /users.json
  def index
    @observation = Observation.find(params[:observation_id])
    @observers = Observer.find_all_by_observation_id(params[:observation_id])
    
    respond_to do |format|
      format.html { render :layout=>"tabs"}
      format.json { render json: @observers }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @observation = Observation.find(params[:observation_id])
    @observer = Observer.new

    @users = User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page]);

   
    respond_to do |format|
      format.js
      format.html #{ render :layout=>"tabs"}
      format.json { render json: @observer }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @observation = Observation.find(params[:observation_id])
    @observer = Observer.new(params[:observer])
    @observer.observation = @observation;

    respond_to do |format|
      if @observer.save
        format.html { redirect_to observation_observers_path(@observation), notice: 'Hospitující byl přídán k hospitaci.' }
        format.json { render json: @observer, status: :created, location: @observer }
      else
        format.html { redirect_to new_observation_observer_path(@observation)}
        format.json { render json: @observer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @observation = Observation.find(params[:observation_id])
    @observer = Observer.find(params[:id])
    @observer.destroy

    respond_to do |format|
      format.html { redirect_to observation_observers_path(@observation), notice: 'Hospitující byl odebrán z hospitace.' }
      format.json { head :ok }
    end
  end
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
