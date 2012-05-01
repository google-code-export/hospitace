# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  check_authorization
   
  helper :all
  helper_method :current_user_session, :current_user, :semester

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
    
  private
  def semester
    return Semester.find_by_code(params[:semester]) unless params[:semester].nil?
    @semester = Semester.current
  end
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    if not request.local? and not request.env["felid-uid"].nil? and session[:user].nil? then
      session[:user] = request.env["felid-uid"]
    end
    #@current_user_session = People.find_by_id session[:user]
    #@current_user_session = People.find_by_username('komarem') #UserSession.find
    @current_user_session = People.find_by_username('turekto5') #UserSession.find
    #@current_user_session = People.find_by_username('cernyvi2') #UserSession.find
    #@current_user_session = People.find_by_username('jinocvla') #UserSession.find
    #@current_user_session = People.find_by_username('necasma2') #UserSession.find
    return @current_user_session
  end
    
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session #&& current_user_session.record
  end
end
