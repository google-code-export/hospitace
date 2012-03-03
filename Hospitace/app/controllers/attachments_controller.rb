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
    
    respond_to do |format|
      format.html # index.html.erb
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
    
    @attachment = Attachment.new
    @attachment.evaluation_id = params[:evaluation_id]
    @attachment.uploaded_file = params[:attachment]
    
    if @attachment.save
      flash[:notice] = "Thank you for your submission..."
      redirect_to :action => "index"
    else
      flash[:error] = "There was a problem submitting your attachment."
      render :action => "new"
    end
    
#    respond_to do |format|
#      if @attachment.save
#        format.html { redirect_to @attachment, notice: 'Attachment was successfully created.' }
#        format.json { render json: @attachment, status: :created, location: @attachment }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @attachment.errors, status: :unprocessable_entity }
#      end
#    end
  end

  # DELETE /attachments/1
  # DELETE /attachments/1.json
  def destroy
    @attachment = Attachment.find(params[:id])
    @attachment.destroy

    respond_to do |format|
      format.html { redirect_to attachments_url }
      format.json { head :ok }
    end
  end
end
