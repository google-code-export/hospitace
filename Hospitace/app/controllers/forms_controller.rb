# encoding: utf-8

class FormsController < ApplicationController
  
  def index
    @evaluation = Evaluation.find params[:evaluation_id]
    @forms = Form.includes(:evaluation,:form_template,:people).
      where(:evaluation_id=>@evaluation.id).
      order("form_template_id ASC");
    
    authorize! :index, @forms
    
    @observation = @evaluation.observation
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
      format.json { render json: @forms }
    end
  end
  
  def code
    @evaluation = Evaluation.find params[:evaluation_id]
    @form_template = FormTemplate.find_by_code(params[:form_template_code])
    
    @forms = Form.joins(:form_template).includes(:evaluation,:form_template,:people).where(
      :evaluation_id=>@evaluation.id,
      "form_templates.code"=>params[:form_template_code]
    )
    
    @form = @forms.first if @form_template.count == "1"
    
    authorize! :index, @forms
    
    @observation = @evaluation.observation
    
    respond_to do |format|
      if @form_template.count == "1"
        format.html { render action: "show",:layout=>"evaluation_tabs" } #evaluation_form_path(@evaluation,@form.id)
      else
        format.html { render :layout=>"evaluation_tabs"}
      end
      format.json { render json: @forms }
    end
  end
  
  def show   
    @form = Form.find params[:id]
    authorize! :show, @form
    
    @attachment = @form.attachments.first;
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
        :people_id=>current_user.id
      })
    authorize! :new, @form
    
    @evaluation = Evaluation.find params[:evaluation_id]
    @observation = @evaluation.observation
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
      format.json { render json: @form }
    end
  end
  
  def edit
    @form = Form.find params[:id]
    
    @evaluation = Evaluation.find params[:evaluation_id]
    @observation = @evaluation.observation
    
    authorize! :edit, @form
    
    respond_to do |format|
      format.html { render :layout=>"evaluation_tabs"}
      format.json { render json: @form }
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @form = Form.find(params[:id])

    authorize! :update, @form
    
    respond_to do |format|
      if update_form(@form,params[:form])
        redirect = edit_evaluation_form_path(@form.evaluation,@form) unless params[:save].nil?
        redirect ||= evaluation_form_path(@form.evaluation,@form.id)
        format.html { redirect_to redirect, notice: 'Formulář byl úspěšně vytvořen.' }
        format.json { head :ok }
      else
        format.html { render action: "edit", :layout=>"evaluation_tabs" }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def create
    @form = Form.new({
        :form_template_id=>params[:form][:form_template_id],
        :evaluation_id=>params[:form][:evaluation_id]
      })#{:form_template_id=>params[:form][:form_template_id]}
    authorize! :create, @form
    
    respond_to do |format|
      if save_form(@form,params[:form])
        redirect = edit_evaluation_form_path(@form.evaluation,@form) unless params[:save].nil?
        redirect ||= evaluation_form_path(@form.evaluation,@form.id)
        
        EvaluationMailer.email_template(@form.evaluation.email_for,@form.email_template,
          :form=>@form,
          :course=>@form.evaluation.observation.course,
          :evaluation=>@form.evaluation
        ) 
        
        format.html { redirect_to redirect, notice: 'Formulář byl úspěšně vytvořen.' }
        format.json { render json: @form, status: :created, location: @form }
      else
        format.html { render action: "new", :layout=>"evaluation_tabs" }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @form = Form.find params[:id]
    
    authorize! :destroy, @form
    
    @form.destroy
    
    evaluation = @form.evaluation
    
    respond_to do |format|
      format.html { redirect_to evaluation_forms_path(evaluation), notice: 'Formulář byl smazán.' }
      format.json { head :ok }
    end
  end
  
  private 
  
  def save_form(form,params)
    
    form.people = current_user
    form.form_template_id = params[:form_template_id]
    form.evaluation_id = params[:evaluation_id]
    
    entries = []
    
    params[:entries].each do |key,value|
      entry = Entry.new
      entry.form = form
      entry.entry_template_id = key.to_i
      entry.value = value
      entries.push(entry)
    end
    
    begin
      ActiveRecord::Base.transaction do
        form.save!
        entries.each { |item| item.save!  }
      end
    rescue ActiveRecord::RecordInvalid => invalid
      return false
    end
    true
  end
  
  def update_form(form,params)
    form.people = current_user
    entries = []
    
    params[:entries].each do |key,value|
      entry = form.entries.where(:entry_template_id=>key.to_i).first
      entry ||= Entry.new({
          :form_id => form.id,
          :entry_template_id => key.to_i
        })
      entry.value = value
      entries.push(entry)
    end
    
    begin
      ActiveRecord::Base.transaction do
        form.save!
        entries.each { |item| item.save!  }
      end
    rescue ActiveRecord::RecordInvalid => invalid
      return false
    end
    true
  end

end
