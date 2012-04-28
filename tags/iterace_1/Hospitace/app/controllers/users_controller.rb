# encoding: utf-8

class UsersController < ApplicationController
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction

  # GET /users
  # GET /users.json
  def index
    @users =  User.search(params[:search]).order(sort_column + " " + sort_direction).paginate(:page => params[:page]) 


    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.includes(:observers,:created_observations).find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    
    session[:path] = new_user_path
    @user.people_id = flash[:people_id] unless flash[:people_id].nil?
    @user.load_people
    @user.login ||= @user.username unless @user.username == "id-"
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    puts params[:user].inspect
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Uživatel byl úspěšně vytvořen.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'Uživatel byl úspěšně upraven.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Uživatel byl smazán.' }
      format.json { head :ok }
    end
  end
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end