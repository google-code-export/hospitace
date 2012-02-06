require 'will_paginate/array'

class UsersController < ApplicationController
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
    @user = User.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    load_persons
    @peoples = People.search(params[:search]).paginate(:page=>params[:page])
    @user = User.new
    
    respond_to do |format|
      format.js
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

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
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
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
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
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
  
  def search_people
    redirect_to :controller=>"peoples",:action=>"index"
  end
  
  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "login"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
  private 
  def load_persons
    @peoples = People.all.paginate(:page => params[:page]) 
  end
end