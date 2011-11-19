class EvaluationsController < ApplicationController
  # GET /evaluations
  # GET /evaluations.json
  def index
   
    if params[:observation_id].nil?
      @evaluations = Evaluation.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @evaluations }
      end

    else
      respond_to do |format|
        format.html { redirect_to Evaluation.find_by_observation_id(params[:observation_id])}
        format.json { redirect_to json: Evaluation.find_by_observation_id(params[:observation_id]) }
      end
      
      
    end  
  end

  # GET /evaluations/1
  # GET /evaluations/1.json
  def show
    @evaluation = Evaluation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @evaluation }
    end
  end

  # GET /evaluations/new
  # GET /evaluations/new.json
  def new
    unless params[:observation_id].nil?
      load_observation(params[:observation_id])
    end
    
    @evaluation = Evaluation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @evaluation }
    end
  end

  # GET /evaluations/1/edit
  def edit
    @evaluation = Evaluation.find(params[:id])
  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    load_observation(params[:evaluation][:observation_id])
    params[:evaluation][:room] ||= @parallel.room.code 

    @evaluation = Evaluation.new(params[:evaluation])
    
      respond_to do |format|
      if @evaluation.save
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully created.' }
        format.json { render json: @evaluation, status: :created, location: @evaluation }
      else
        format.html { render action: "new" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /evaluations/1
  # PUT /evaluations/1.json
  def update
    @evaluation = Evaluation.find(params[:id])

    respond_to do |format|
      if @evaluation.update_attributes(params[:evaluation])
        format.html { redirect_to @evaluation, notice: 'Evaluation was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1
  # DELETE /evaluations/1.json
  def destroy
    @evaluation = Evaluation.find(params[:id])
    @evaluation.destroy

    respond_to do |format|
      format.html { redirect_to evaluations_url }
      format.json { head :ok }
    end
  end
  
  private 
  
  def load_observation(observation_id)
      @observation = Observation.find(observation_id)
      @parallel = @observation.find_parallel
      @course = @observation.find_course
  end
end
