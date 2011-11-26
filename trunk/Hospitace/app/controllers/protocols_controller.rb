class ProtocolsController < ApplicationController
  def index
  end

  def show
    @protocol = Protocol.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @protocol }
    end
  end

  def new
    @protocol = Protocol.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @protocol }
    end
  end
  
  def create
    @protocol = Protocol.new(params[:protocol])
    puts @protocol.inspect
    respond_to do |format|
      if @protocol.save
        format.html { redirect_to @protocol, notice: 'Protocal was successfully created.' }
        format.json { render json: @protocol, status: :created, location: @protocol }
      else
        format.html { render action: "new" }
        format.json { render json: @protocol.errors, status: :unprocessable_entity }
      end
    end
  end

end
