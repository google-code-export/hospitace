
require 'will_paginate/array'

class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  def index
    
    @courses = Course.search(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  end
  
  def show
    @course = Course.find_by_code(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end
  
  def instances
    @instances = @course.instance
  end

end
