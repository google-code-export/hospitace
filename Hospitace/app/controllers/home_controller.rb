class HomeController < ApplicationController
  skip_authorization_check
  
  def index
    @semesters = Semester.find_current_and_next
    @observations = []
    
    @semesters.each do |s|
      @observations << {
        :semester=>s,
        :observations=> Observation.includes(:created_by,:users).where(:semester=>s.code,:observation_type=>[:reported,:floating])
        }
    end

    respond_to do |format|
      format.js
      format.html # index.html.erb
    end
  end

end
