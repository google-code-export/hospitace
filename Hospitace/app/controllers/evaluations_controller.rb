# encoding: utf-8

class EvaluationsController < ApplicationController
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction
  
  def index
    @evaluations =  Evaluation.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page]) 


    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @evaluations }
    end
  end
  
  # GET /evaluations/1
  # GET /evaluations/1.json
  def show
    @evaluation = Evaluation.find(params[:id])
    @observation = @evaluation.observation
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
      format.json { render json: @evaluation }
    end
  end

  # GET /evaluations/new
  # GET /evaluations/new.json
  def new
    
    @observation = Observation.find params[:observation_id]
    
    session[:path] = new_observation_evaluation_path(@observation);
    
    session[:teacher_id] = flash["teacher_id"] unless flash["teacher_id"].nil?
    session[:guarant_id] = flash["guarant_id"] unless flash["guarant_id"].nil?
    
    @evaluation = Evaluation.new({
        :observation_id => params[:observation_id],
        :course  => course,
        :teacher => teacher,
        :guarant => guarant,
        :room  => room
      })
    

    respond_to do |format|
      format.html { render :layout=>"tabs"}
      format.json { render json: @evaluation }
    end
  end

  # GET /evaluations/1/edit
  def edit
    @evaluation = Evaluation.find(params[:id])
    @observation = @evaluation.observation
    
    session[:path] = edit_evaluation_path(@evaluation)

    session[:teacher_id] = flash["teacher_id"] unless flash["teacher_id"].nil?
    session[:guarant_id] = flash["guarant_id"] unless flash["guarant_id"].nil?
       
    @evaluation.teacher = People.find_by_id(session[:teacher_id]) || @evaluation.teacher
    @evaluation.guarant = People.find_by_id(session[:guarant_id]) || @evaluation.guarant
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
      format.json { render json: @evaluation }
    end
  end

  # POST /evaluations
  # POST /evaluations.json
  def create
    #@observation = Observation.find params[:observation_id]
    @evaluation = Evaluation.new(params[:evaluation])
    @observation = @evaluation.observation
    respond_to do |format|
      if @evaluation.save
        session.delete(:teacher_id)
        session.delete(:guarant_id)
        session.delete(:path)
        format.html { redirect_to observation_evaluation_path(@observation,@evaluation), notice: 'Hodnocení bylo úspěšně vytvořeno.' }
        format.json { render json: @evaluation, status: :created, location: @evaluation }
      else
        format.html { render action: "new", :layout => "tabs" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /evaluations/1
  # PUT /evaluations/1.json
  def update
    @evaluation = Evaluation.find(params[:id])
    @observation = @evaluation.observation
    
    respond_to do |format|
      if @evaluation.update_attributes(params[:evaluation])
        session.delete(:teacher_id)
        session.delete(:guarant_id)
        session.delete(:path)
        format.html { redirect_to evaluation_path(@evaluation), notice: 'Hodnocení bylo úspěšně upraveno.' }
        format.json { head :ok }
      else
        format.html { render action: "edit", :layout => "evaluation_tabs" }
        format.json { render json: @evaluation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @evaluation = Evaluation.find(params[:id])
    @evaluation.destroy

    respond_to do |format|
      format.html { redirect_to evaluations_url, notice: 'Hodnocení bylo smazáno.' }
      format.json { head :ok }
    end
  end
  
  def sort_column
    Evaluation.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
    
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  private
    
  def teacher
    return nil if @observation.parallel.nil?   
    People.find_by_id(session[:teacher_id]) || @observation.parallel.teachers.first
  end
  
  def guarant
    return nil if @observation.instance.nil? 
    People.find_by_id(session[:guarant_id]) || @observation.instance.guarantors.first
  end
  
  def course
    @observation.course.code unless @observation.course.nil?
  end
  
  def room
    return nil if @observation.parallel.nil?  
    @observation.parallel.room.code unless @observation.parallel.room.nil?

  end
  

  
end