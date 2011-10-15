require 'lib/kosapi.rb' 

class CoursesController < ApplicationController
  # GET /observations
  # GET /observations.json
  def index
    
    @courses = KOSapi::Course.all;

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end
  
  def show
    @course = KOSapi::Course.find_by_code(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end

end
