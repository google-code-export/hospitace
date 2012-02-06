class NotesController < ApplicationController
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction

  # GET /users
  # GET /users.json
  def index
    @observation = Observation.find(params[:observation_id])
    @notes =  Note.find_all_by_observation_id(params[:observation_id])
    @note = Note.new
    @note.observation = @observation
    
    respond_to do |format|
      format.html { render :layout=>"tabs"}
      format.json { render json: @notes }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @note = Note.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /users/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @note = Note.new(params[:note])
    @note.user = current_user
    
    respond_to do |format|
      if @note.save
        format.html { redirect_to observation_notes_path(@note.observation), notice: 'Poznámka byla úspěšně vytvořená.' }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: new_observations_note_path(@note.observation) }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @note = Note.find(params[:id])
    @observation = @note.observation
    
    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to observation_notes_path(@observation), notice: 'Poznámka byla úspěšně upravená.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    
    @note = Note.find(params[:id])
    @observation = @note.observation
    @note.destroy

    respond_to do |format|
      format.html { redirect_to observation_notes_path(@observation), notice: 'Poznámka byla smazána.' }
      format.json { head :ok }
    end
  end
  
  
  def sort_column
    Note.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
