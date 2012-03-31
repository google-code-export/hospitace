# encoding: utf-8

require 'kosapi'

namespace :import do
  task :course => :environment do
    
    added = 0;
    updated = 0;
      
    beginning = Time.now
    
    item = 0
    count = KOSapi::Course.all.size
    KOSapi::Course.all.each do |course|
      begin
      
        item += 1
        c = Course.find_by_code(course.code);
        puts "Processing course with code: #{course.code} #{item}/#{count}"
        if c.nil? then
          c = Course.create({
              :classes_type => course.classes_type,
              :range => course.range,
              :semester_season => course.semester_season,
              :study_form => course.study_form,
              :code => course.code ,
              :status => course.status,
              :completion => course.completion,
              :credits => course.credits,
              :description => course.description,
              :name => course.name
            })
          added+=1 if c.save!
        else
          if c.classes_type != course.classes_type then
            c.classes_type = course.classes_type
            c.save!
          end
        
          if c.range != course.range then
            c.range = course.range
            c.save!
          end
          
          if c.semester_season != course.semester_season then
            c.semester_season = course.semester_season
            c.save!
          end
          
          if c.study_form != course.study_form then
            c.study_form = course.study_form
            c.save!
          end
         
          if c.code != course.code then
            c.code = course.code
            c.save!
          end
        
          if c.status != course.status then
            c.status = course.status
            c.save!
          end
          
          if c.completion != course.completion then
            c.completion = course.completion
            c.save!
          end
          
          if c.credits != course.credits then
            c.credits = course.credits
            c.save!
          end
          
          if c.description != course.description then
            c.description = course.description
            c.save!
          end
          
          if c.name != course.name then
            c.name = course.name
            c.save!
          end
          
          updated+=1
        end
        
      rescue
        @error_message="#{$!}"
        puts @error_message unless @error_message == "closed MySQL connection"
      ensure
      end
    end
    puts "Created courses #{added}"
    puts "Updated courses #{updated}"
    puts "Total courses #{KOSapi::Course.all.size}"
    final = Time.now - beginning
  end

end