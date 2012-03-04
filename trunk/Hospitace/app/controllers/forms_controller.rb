class FormsController < ApplicationController
  
  def index
    @forms = Form.all
    authorize! :show, @forms
    
    @evaluation = Evaluation.find params[:evaluation_id]
    @observation = @evaluation.observation
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
      format.json { render json: @forms }
    end
  end
  
  def show   
    @form = Form.find params[:id]
    authorize! :show, @form
    
    @evaluation = Evaluation.find params[:evaluation_id]
    @observation = @evaluation.observation
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
      format.json { render json: @form }
    end
  end
  
  def new
    template = FormTemplate.find_by_code(params[:form_template_code])
    
    @form = Form.new({
        :form_template_id=> template.nil? ? nil : template.id , 
        :evaluation_id=>params[:evaluation_id],
        :user_id=>current_user.id
      })
    authorize! :new, @form
    
    @evaluation = Evaluation.find params[:evaluation_id]
    @observation = @evaluation.observation
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
      format.json { render json: @form }
    end
  end
  
  def create
    @form = Form.new({:form_template_id=>1})
    authorize! :create, @form
    
    respond_to do |format|
      if save_dynamic_form(params)
        format.html { redirect_to @form, notice: 'Formulář byl úspěšně vytvořen.' }
        format.json { render json: @form, status: :created, location: @form }
      else
        format.html { render action: "new", :layout=>"evaluation_tabs" }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

end
