# encoding: utf-8

class ParallelsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @parallels = Parallel.find_by_course_id_and_semester_id(params[:course_id],params[:semester_id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parallels }
    end
  end
  
  def select
    session[:path] ||= course_parallels_path(params[:course_id])
    
    unless params[:parallel_id].nil?
      redirect_to session[:path], :flash => { :parallel_id=>params[:parallel_id]}
      return
    end
    
    @parallels = Parallel.find_by_course_id_and_semester_id(params[:course_id],params[:semester_id])
    respond_to do |format|
      format.html 
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
