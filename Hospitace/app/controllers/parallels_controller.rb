class ParallelsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @parallels = Parallel.find_by_course(params[:course_id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parallels }
    end
  end

  def show
    #@parallel = Parallel.find(parrams[:course_id],parrams[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parallel }
    end
  end

end
