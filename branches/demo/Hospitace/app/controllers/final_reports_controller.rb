class FinalReportsController < ApplicationController
  def index
    @final_reports = FinalReport.all


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @final_reports }
    end
  end

  def show
    @final_report = FinalReport.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @final_report }
    end
  end

  def new
    @final_report = FinalReport.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @final_report }
    end
  end
  
  def create
    @final_report = FinalReport.new(params[:final_report])

    respond_to do |format|
      if @final_report.save
        format.html { redirect_to @final_report, notice: 'Protocal was successfully created.' }
        format.json { render json: @final_report, status: :created, location: @final_report }
      else
        format.html { render action: "new" }
        format.json { render json: @final_report.errors, status: :unprocessable_entity }
      end
    end
  end

end
