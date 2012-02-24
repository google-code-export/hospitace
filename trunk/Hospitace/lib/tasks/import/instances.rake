# encoding: utf-8

require 'kosapi'

namespace :import do
  task :instances => :environment do
    
    added_instances = 0;
    updated_instances = 0;
    added_parallels = 0;
    updated_parallels = 0;
    
    def process_related(instance,peoples,relation)
      peoples.each do |p|
        instance.send(relation).create({:relation=>relation, :people_id=>p.id})  
      end
    end
    
    def related(instance,persisted_instance)
      process_related(persisted_instance,instance.editors,"editors")
      process_related(persisted_instance,instance.examiners,"examiners")
      process_related(persisted_instance,instance.guarantors,"guarantors")
      process_related(persisted_instance,instance.instructors,"instructors")
      process_related(persisted_instance,instance.lecturers,"lecturers")
    end
    
    beginning = Time.now
    
    #current_semester = Semester.find_by_code KOSapi::Semester.current_semester.code
    semesters = Semester.current_and_next
    
    course_count = Course.all.size
    
    item = 0
    Course.all.each do |course|
      begin
      
        item += 1
        puts "Course #{item}/#{course_count}"
       
        semesters.each do |s|
          
          i = KOSapi::Course.find_by_code(course.code).instance(s.code)
          if(i.nil?)
            puts "Skipping course instances with code: #{course.code}, semester: #{s.code}"
            next
          end
          
          instance = CourseInstance.find_by_course_id_and_semester_id(course.id,s.id);
          #puts "Processing course instances with code: #{course.code}, semester: #{s.code}"
          puts "- instances #{s.code}"
          if instance.nil?
            instance = CourseInstance.create({
                :capacity => i.capacity,
                :occupied => i.occupied,
                :semester => s,
                :course   => course
              })
            instance.save!
            instance = CourseInstance.find_by_course_id_and_semester_id(course.id,s.id);
            #puts "Processing people_relateds"
            puts "-- peoles"
            related(i,instance)
          else
            #puts "Updating course instances with code: #{course.code}, semester: #{s.code}"
          end
          
          parallels = i.parallels
          puts "-- parallels #{parallels.size}"
          parallels.each do |p|
            
            parallel = Parallel.find_by_course_instance_id_and_number(instance.id,p.parallel_number)
            if parallel.nil?
              parallel = instance.parallels.create({
                  :day => p.day,
                  :first_hour => p.first_hour,
                  :last_hour => p.last_hour,
                  :number  => p.parallel_number,
                  :parity  => p.parity,
                  :parallel_type => p.type,
                  :room_id  => Room.find_by_code(p.room.code).id
                })
              
              puts "--- teachers #{p.teachers.size}"
              process_related(parallel,p.teachers,"teachers")
            end
          end
        end
        
      rescue
        @error_message="#{$!}"
        puts @error_message
      ensure
      end
    end
    puts "Created instances #{added_instances}"
    puts "Updated instances #{updated_instances}"
    puts "Created parallels #{added_parallels}"
    puts "Updated parallels #{updated_parallels}"
    final = Time.now - beginning
  end

end