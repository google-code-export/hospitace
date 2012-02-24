# encoding: utf-8

require 'kosapi'

namespace :import do
  task :course => :environment do
    
    added_courses = 0;
    updated_courses = 0;
      
    beginning = Time.now
    
    course_count = KOSapi::Course.all.size
    
    item = 0
    KOSapi::Course.all.each do |course|
      begin
      
        item += 1
        puts "Course #{item}/#{course_count}"


        c = Course.find_by_code(course.code);
        puts "Processing course with code: #{course.code}"
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
          c.save!
          added_courses+=1
        else
          puts "Updating course with code: #{course.code}"
          #TODO
          updated_courses+=1
        end
        
      rescue
        @error_message="#{$!}"
        puts @error_message unless @error_message == "closed MySQL connection"
      ensure
      end
    end
    puts "Created courses #{added_courses}"
    puts "Updated courses #{updated_courses}"
    puts "Total courses #{course_count}"
    final = Time.now - beginning
  end

end