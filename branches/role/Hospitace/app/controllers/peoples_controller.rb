
require 'will_paginate/array'

class PeoplesController < ApplicationController
  
  # GET /peoples
  # GET /peoples.json
  def index
    
    @peoples = KOSapi::User.all.find_all { |e| e.username=~ /#{params[:search]}/  }.paginate(:page => params[:page])

    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @peoples }
    end
  end

  # GET /peoples/1
  # GET /peoples/1.json
  def show
    @people = KOSapi::User.find_by_id(params[:id]);
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @people }
    end
  end
  
  def search
    @peoples = KOSapi::User.all.find_all { |e| e.username=~ /#{params[:search]}/  }.paginate(:page => params[:page])
    
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @peoples }
    end
  end
  
  def peoples
    index
  end
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
