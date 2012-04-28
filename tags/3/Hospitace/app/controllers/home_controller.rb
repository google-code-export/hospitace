# encoding: utf-8

class HomeController < ApplicationController
  skip_authorization_check
  
  def index
    @semesters = Semester.current_and_next
    
    puts @semesters.inspect
    @observations = []
    
    @semesters.each do |s|
      @observations << {
        :semester=>s,
        :observations=> Observation.includes(:created_by,:observers_people,:course).where(:semester_id=>s.id,:observation_type=>[:reported,:floating])
        }
    end

    respond_to do |format|
      format.js
      format.html # index.html.erb
    end
  end

end
