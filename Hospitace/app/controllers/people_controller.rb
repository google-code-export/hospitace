# encoding: utf-8

class PeopleController < ApplicationController
  load_and_authorize_resource
  helper_method :sort_column, :sort_direction
  
  # GET /peoples
  # GET /peoples.json
  def index
    
    @peoples = People.includes(:role).search(params[:search]).paginate(:page=>params[:page])

    respond_to do |format|
      format.js
      format.html 
      format.json { render json: @peoples }
    end
  end
  
  def select
    session[:path] ||= people_path
    
    unless params[:people_id].nil?
      flash_name = params[:type].nil? ? :people_id : "#{params[:type]}_id" 
      redirect_to session[:path], :flash => { flash_name=>params[:people_id]}
      return
    end
    
    @peoples = People.includes(:role).search(params[:search]).paginate(:page=>params[:page])
    
    respond_to do |format|
      format.js
      format.html 
      format.json { render json: @peoples }
    end
  end
  
  # GET /peoples/1
  # GET /peoples/1.json
  def show
    @people = People.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @people }
    end
  end
  
   # GET /users/1/edit
  def edit
    @people = People.find(params[:id])
    @people.role ||= Role.new() 
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @people = People.find(params[:id])

    respond_to do |format|
      if @people.update_attributes(params[:people])
        format.html { redirect_to @people, notice: 'Uživatel byl úspěšně upraven.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @people.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def sort_column
    (params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
