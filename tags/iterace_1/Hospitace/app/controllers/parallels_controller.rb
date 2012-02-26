# encoding: utf-8

class ParallelsController < ApplicationController
  load_and_authorize_resource
  
  def index
    @parallels = Parallel.find_by_course(params[:course_id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parallels }
    end
  end
  
  def select
    session[:path] ||= course_parallels_path(params[:course_id])
    
    unless params[:parallel].nil?
      redirect_to session[:path], :flash => { :parallel=>params[:parallel]}
      return
    end
    
    @parallels = Parallel.find_by_course(params[:course_id])
    puts @parallels
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
