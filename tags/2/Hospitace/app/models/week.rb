# To change this template, choose Tools | Templates
# and open the template in the editor.

class Week
  DAYS = [ 
         "MONDAY",
         "TUESDAY",
         "WEDNESDAY",
         "THURSDAY",
         "FRIDAY",
         "SATURDAY",
         "SUNDAY"
         ]
  
  def self.current_week current_semester
    if Date.today.to_time.to_i < current_semester.start_date.to_time.to_i
      week = 1
    elsif Date.today.to_time.to_i > current_semester.end_date.to_time.to_i
      week = 14
    else
      week = (((Date.today - current_semester.start_date) / 7) + 1).to_i
    end
    
    # If we are int he period of exams, last "normal" week of the semester should be displayed
    if week > 14 then
      week = 14
    end
    
    week
  end
  
  def self.start_date 
  end
  
  def initialize
    
  end
  
  def self.dates parallel,semester

    dates = []
    return dates if parallel.nil?
    date = semester.start
    shift = Week::DAYS.index(parallel.day)
    (0..13).each do |i| 
      # todo: sudý lichý týden
      dates << Date.jd(date.jd + shift + 7*i)
    end
    dates
  end
end
