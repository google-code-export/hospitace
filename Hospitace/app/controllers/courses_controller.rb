# encoding: utf-8

require 'will_paginate/array'

class CoursesController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  # GET /courses
  # GET /courses.json
  def index
    
    @courses = Course.search(params[:search]).paginate(:page => params[:page])

    respond_to do |format|
      format.js
      format.html
      format.json { render json: @courses }
    end
  end
   
  def select
    session[:path] ||= courses_path
    
    unless params[:course].nil?
      redirect_to session[:path], :flash => { :course=>params[:course]}
      return
    end
    
    @courses = Course.search(params[:search]).paginate(:page => params[:page])
    
    respond_to do |format|
      format.js
      format.html 
      format.json { render json: @courses }
    end
  end
  
  def show
    @course = Course.find_by_code(params[:id])
    
    respond_to do |format|
      format.js
      format.html # show.html.erb
      format.json { render json: @course }
    end
  end
  
  def instances
    @instances = @course.instance
  end
  
  def sort_column
    (params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
