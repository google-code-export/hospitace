class ObserversController < ApplicationController
  load_and_authorize_resource

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
    @observer = Observer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @observer }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @observer = Observer.new(params[:observer])
    respond_to do |format|
      if @observer.save
        format.html { redirect_to @observer, notice: 'User was successfully created.' }
        format.json { render json: @observer, status: :created, location: @observer }
      else
        format.html { render action: "new" }
        format.json { render json: @observer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @observer = Observer.find(params[:id])
    @observer.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
end
