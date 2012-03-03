class DocumentsController < ApplicationController
  def a
    authorize! :index, Observation
    
    @evaluation = Evaluation.find params[:evaluation_id]
    @observation = @evaluation.observation
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
    end
  end

  def b
    authorize! :index, Observation
    
    @evaluation = Evaluation.find params[:evaluation_id]
    @observation = @evaluation.observation
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
    end
  end

  def c
    authorize! :index, Observation
    
    @evaluation = Evaluation.find params[:evaluation_id]
    @observation = @evaluation.observation
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
    end
  end

  def d
    authorize! :index, Observation
    
    @evaluation = Evaluation.find params[:evaluation_id]
    @observation = @evaluation.observation
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
    end
  end
  
  def create
    authorize! :create, Form
    
    respond_to do |format|
      if save_dynamic_form(params)
        format.html { redirect_to Observation.new, notice: 'Formulář byl úspěšně vytvořen.' }
        format.json { render json: Observation.new, status: :created, location: Observation.new }
      else
        format.html { render action: "new" }
        format.json { render json: Observation.new.errors, status: :unprocessable_entity }
      end
    end
  end

end
