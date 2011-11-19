class FinalReportsController < ApplicationController
  # GET /final_reports
  # GET /final_reports.json
  def index
    @final_reports = FinalReport.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @final_reports }
    end
  end

  # GET /final_reports/1
  # GET /final_reports/1.json
  def show
    @final_report = FinalReport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @final_report }
    end
  end

  # GET /final_reports/new
  # GET /final_reports/new.json
  def new
    @final_report = FinalReport.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @final_report }
    end
  end

  # GET /final_reports/1/edit
  def edit
    @final_report = FinalReport.find(params[:id])
  end

  # POST /final_reports
  # POST /final_reports.json
  def create
    @final_report = FinalReport.new(params[:final_report])

    respond_to do |format|
      if @final_report.save
        format.html { redirect_to @final_report, notice: 'Final report was successfully created.' }
        format.json { render json: @final_report, status: :created, location: @final_report }
      else
        format.html { render action: "new" }
        format.json { render json: @final_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /final_reports/1
  # PUT /final_reports/1.json
  def update
    @final_report = FinalReport.find(params[:id])

    respond_to do |format|
      if @final_report.update_attributes(params[:final_report])
        format.html { redirect_to @final_report, notice: 'Final report was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @final_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /final_reports/1
  # DELETE /final_reports/1.json
  def destroy
    @final_report = FinalReport.find(params[:id])
    @final_report.destroy

    respond_to do |format|
      format.html { redirect_to final_reports_url }
      format.json { head :ok }
    end
  end
end
