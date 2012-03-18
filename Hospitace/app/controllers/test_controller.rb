class TestController < ApplicationController
  def index
     
    
    authorize! :index, Observation
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def show   
    @form = Form.find params[:id]
    authorize! :show, Observation
    
    
    respond_to do |format|
      format.html
      format.json { render json: @form }
    end
  end
  
  def new
    @form = Form.new({
        :form_template_id=> 1, 
        :evaluation_id=>2,
        :user_id=>current_user.id
      })
    
    root_templates = @form.form_template.entry_templates.root 
    
    root_templates.each do |t|
      @form.root_entries.build do |b|
        b.value = "B"
        b.entry_template_id = t.id
      end
    end
   
    authorize! :index, @form
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @form }
    end
  end
  
  # POST /users
  # POST /users.json
  def create
    @form = Form.new(params[:form])
    respond_to do |format|
      if @form.save
        format.html { redirect_to @form, notice: 'Uživatel byl úspěšně vytvořen.' }
        format.json { render json: @form, status: :created, location: @form }
      else
        format.html { render action: "new" }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @form = Form.find params[:id]
    
    root_templates = @form.form_template.entry_templates.root 
    root_templates.each do |t|
      next if t.entries.where(:form_id=>@form.id).exists?
      @form.root_entries.build do |b|
        b.value = "root #{t.label}"
        b.entry_template_id = t.id
      end
    end
    
    authorize! :index, @form
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @form }
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @form = Form.find(params[:id])

    respond_to do |format|
      if @form.update_attributes(params[:form])
        format.html { redirect_to @form, notice: 'Uživatel byl úspěšně upraven.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end
