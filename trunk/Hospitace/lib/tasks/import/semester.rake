# encoding: utf-8

require 'kosapi'

namespace :import do
  task :semester => :environment do
    beginning = Time.now
    
    added = 0
    updated = 0
    
    KOSapi::Semester.all.each do |semester|
      s = Semester.find_by_code semester.code
      if s.nil? then
        s = Semester.create(
          :code         => semester.code,
          :name         => semester.name,
          :start   => semester.start,
          :end     => semester.end)
        
        added += 1
      else
        if s.name != semester.name then
          s.name = semester.name
          s.save!
        end
        
        if s.start != semester.start then
          s.start = semester.start
          s.save!
        end
        
        if s.end != semester.end then
          s.end = semester.end
          s.save!
        end
        
        updated+=1
      end
    end
    
    puts "Created semesters #{added}"
    puts "Updated semesters #{updated}"
    puts "Total rooms #{KOSapi::Semester.all.size}"
    
    final = Time.now - beginning
  end
end