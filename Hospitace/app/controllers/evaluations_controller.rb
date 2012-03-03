# encoding: utf-8

class EvaluationsController < ApplicationController
  load_and_authorize_resource
  
  # GET /users/1
  # GET /users/1.json
  def show
    @evaluation = Evaluation.find(params[:id])
    @observation = @evaluation.observation
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
      format.json { render json: @evaluation }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @observation = Observation.find params[:observation_id]
    @evaluation = Evaluation.new({
        :observation_id => params[:observation_id],
        :teacher => @observation.parallel.teachers.first.full_name,
        :guarant => @observation.instance.guarantors.first.full_name,
        :course  => @observation.course.code,
        :room  => @observation.parallel.room.code ,
        :datetime_observation => @observation.date
    })
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
      format.json { render json: @evaluation }
    end
  end

  # GET /users/1/edit
  def edit
    @evaluation = Evaluation.find(params[:id])
    @observation = @evaluation.observation
  end

  # POST /users
  # POST /users.json
  def create
    #@observation = Observation.find params[:observation_id]
    @evaluation = Evaluation.new(params[:evaluation])
    @observation = @evaluation.observation
    respond_to do |format|
      if @evaluation.save
        format.html { redirect_to observation_evaluation_path(@observation,@evaluation), notice: 'Hodnocení bylo úspěšně vytvořeno.' }
        format.json { render json: @evaluation, status: :created, location: @evaluation }
      else
        format.html { render action: "new" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @evaluation = Evaluation.find(params[:id])

    respond_to do |format|
      if @evaluation.update_attributes(params[:evaluation])
        format.html { redirect_to observation_evaluation_path(@evaluation.observation,@evaluation), notice: 'Hodnocení bylo úspěšně upraveno.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end
end