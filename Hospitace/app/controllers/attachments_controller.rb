# encoding: utf-8

class AttachmentsController < ApplicationController
  load_and_authorize_resource
  
  # GET /attachments
  # GET /attachments.json
  def index
    @attachment = Attachment.new
    unless params[:evaluation_id].nil?
      @attachments = Attachment.find_all_by_evaluation_id(params[:evaluation_id])
      @attachment.evaluation_id = params[:evaluation_id]
    else
      @attachments = Attachment.all
    end  
    
    @evaluation = Evaluation.find params[:evaluation_id] ||= params[:attachment][:evaluation_id]
    
    respond_to do |format|
      format.html { render "index", :layout=>"evaluation_tabs" }
      format.json { render json: @attachments }
    end
  end

  # GET /attachments/1
  # GET /attachments/1.json
  def show
    @attachment = Attachment.find(params[:id])
    send_data @attachment.data, :filename => @attachment.filename, :type=>@attachment.content_type
  end

  # POST /attachments
  # POST /attachments.json
  def create
    return if params[:attachment].blank?
    @attachment = Attachment.new({
        :evaluation_id => params[:attachment][:evaluation_id],
        :people_id => current_user.id,
        :form_id => params[:attachment][:form_id]
      })
    @attachment.uploaded_file = params[:attachment]
    
    unless params[:evaluation_id].nil?
      @attachments = Attachment.find_all_by_evaluation_id(params[:evaluation_id])
    else
      @attachments = Attachment.all
    end  
    
    @evaluation = @attachment.evaluation
    
    red = @attachment.evaluation.nil? ? attachments_path : evaluation_attachments_path(@attachment.evaluation)
    respond_to do |format|
      if @attachment.save
        format.js
        format.html { redirect_to red, notice: 'Attachment was successfully created.', :layout=>"evaluation_tabs" }
        format.json { render json: @attachment, status: :created, location: @attachment }
      else
        format.js   
        format.html { render action: "index", :layout=>"evaluation_tabs" }
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment = Attachment.find(params[:id])
    clone = Attachment.new( @attachment.attributes )
    evaluation = @attachment.evaluation
    @attachment.destroy

    @attachment = clone
    
    respond_to do |format|
      format.html { redirect_to evaluation.nil? ? {:action => "index"} : evaluation_attachments_path(evaluation) }
      format.json { head :ok }
      format.js
    end
  end
end
