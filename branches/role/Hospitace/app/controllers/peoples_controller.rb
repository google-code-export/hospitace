require 'kosapi'

class PeoplesController < ApplicationController
  
  # GET /peoples
  # GET /peoples.json
  def index
    @peoples = KOSapi::User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @peoples }
    end
  end

  # GET /peoples/1
  # GET /peoples/1.json
  def show
    @peoples = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @peoples }
    end
  end
  
end
