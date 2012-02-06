class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization
  
  helper :all
  helper_method :current_user_session, :current_user, :semester

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  def semester
    return @semester if defined?(@semester)
    return Semester.find_by_code(params[:semester]) unless params[:semester].nil?
    @semester = Semester.current_semester 
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
