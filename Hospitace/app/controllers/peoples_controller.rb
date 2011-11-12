
require 'will_paginate/array'

class PeoplesController < ApplicationController
  
  # GET /peoples
  # GET /peoples.json
  def index
    
    @peoples = People.search(params[:search]).paginate(:page=>params[:page])

    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @peoples }
    end
  end

  # GET /peoples/1
  # GET /peoples/1.json
  def show
    @people = People.find_by_id(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @people }
    end
  end
  
#  def sort_column
#    User.column_names.include?(params[:sort]) ? params[:sort] : "id"
#  end
#  
#  def sort_direction
#    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
#  end
end
