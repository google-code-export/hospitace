# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization
  
  helper :all
  helper_method :current_user_session, :current_user, :semester

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def semester
    #return @semester if defined?(@semester)
    return Semester.find_by_code(params[:semester]) unless params[:semester].nil?
    @semester = Semester.current
  end
  
  def save_dynamic_form(params)
    form = Form.new
    form.user = current_user
    
    entries = []
    
    params[:form].each do |key,value|
      case key
        when "form_template_id"
            form.form_template_id = value

        when "evaluation_id"
            form.evaluation_id = value
            
        else
          entry = Entry.new
          entry.form = form
          entry.entry_template_id = key.to_i
          entry.value = value
          entries.push(entry)
      end  
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
  
  
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
    
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
end
