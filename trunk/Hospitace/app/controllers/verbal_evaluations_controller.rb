class VerbalEvaluationsController < ApplicationController
  def index
  end

  def show
    @verbal_evaluation = VerbalEvaluation.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @verbal_evaluation }
    end
  end

  def new
    @verbal_evaluation = VerbalEvaluation.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @verbal_evaluation }
    end
  end
  
  def create
    @verbal_evaluation = VerbalEvaluation.new(params[:verbal_evaluation])
    respond_to do |format|
      if @verbal_evaluation.save
        format.html { redirect_to @verbal_evaluation, notice: 'Protocal was successfully created.' }
        format.json { render json: @verbal_evaluation, status: :created, location: @verbal_evaluation }
      else
        format.html { render action: "new" }
        format.json { render json: @verbal_evaluation.errors, status: :unprocessable_entity }
      end
    end
  end

end
