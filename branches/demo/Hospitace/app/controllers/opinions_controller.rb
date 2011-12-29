class OpinionsController < ApplicationController
  def index
  end

  def show
    @opinion = Opinion.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @opinion }
    end
  end

  def new
    @opinion = Opinion.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @opinion }
    end
  end
  
  def create
    @opinion = Opinion.new(params[:opinion])
    puts @opinion.inspect
    respond_to do |format|
      if @opinion.save
        format.html { redirect_to @opinion, notice: 'Protocal was successfully created.' }
        format.json { render json: @opinion, status: :created, location: @protocol }
      else
        format.html { render action: "new" }
        format.json { render json: @opinion.errors, status: :unprocessable_entity }
      end
    end
  end

end
