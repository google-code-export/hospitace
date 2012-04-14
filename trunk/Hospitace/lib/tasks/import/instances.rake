# encoding: utf-8

require 'kosapi'

namespace :import do
  task :instances => :environment do
    
    added_instances = 0;
    updated_instances = 0;
    added_parallels = 0;
    updated_parallels = 0;
    
    def process_related(instance,kos_instance,relation)
      peoples = kos_instance.send(relation)
      # vytvori relace pokud neexistuji
      peoples.each do |p|
        related = instance.send(relation).find_by_id p.id
        if related.nil?
          r = PeoplesRelated.new({
              :relation=>relation, 
              :people_id=>p.id,
              :related=>instance
            })
          r.save!
        end 
      end
      peoples_db = instance.send(relation)
      peoples_db.each do |p|
        unless people_in_array?(p,peoples)
          rel = instance.peoples_relateds.find_by_people_id_and_relation(p.id,relation)
          rel.destroy 
        end
      end
    end
    
    def people_in_array?(people,array)
      array.each do |p|
          if p.id.to_i == people.id.to_i
            return true 
          end
      end
      false
    end
          
    def related(instance,persisted_instance)
      process_related(persisted_instance,instance,"editors")
      process_related(persisted_instance,instance,"examiners")
      process_related(persisted_instance,instance,"guarantors")
      process_related(persisted_instance,instance,"instructors")
      process_related(persisted_instance,instance,"lecturers")
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
       
        semesters.each do |semester|
          
          i = KOSapi::Course.find_by_code(course.code).instance(semester.code)
          # pokud instance neexistuje tak ji vynecha
          if(i.nil?)
            next
          end
          
          instance = CourseInstance.find_by_course_id_and_semester_id(course.id,semester.id);
          #puts "Processing course instances with code: #{course.code}, semester: #{s.code}"
          if instance.nil?
            instance = CourseInstance.create({
                :capacity => i.capacity,
                :occupied => i.occupied,
                :semester => semester,
                :course   => course
              })
            added_instances+=1 if instance.save!
            # vytvori relace mezi uzivately a instanci predmetu
            instance = CourseInstance.find_by_course_id_and_semester_id(course.id,semester.id);
            related(i,instance)
          else
            if instance.capacity != i.capacity then
              instance.capacity = i.capacity
              instance.save!
            end
            
            if instance.occupied != i.occupied then
              instance.occupied = i.occupied
              instance.save!
            end
            
            #TODO
            related(i,instance)
            updated_instances+=1
          end
          
          instance = CourseInstance.find_by_course_id_and_semester_id(course.id,semester.id);
          
          parallels = i.parallels
          parallels.each do |p|
            parallel = Parallel.find_by_course_instance_id_and_number(instance.id,p.parallel_number)
            if parallel.nil?
              parallel = instance.parallels.build({
                  :day => p.day,
                  :first_hour => p.first_hour,
                  :last_hour => p.last_hour,
                  :number  => p.parallel_number,
                  :parity  => p.parity,
                  :parallel_type => p.type
                })
              parallel.room = Room.find_by_code(p.room.code) unless p.room.nil?
              added_parallels+=1 if parallel.save!
              
              process_related(parallel,p,"teachers")
            else
              if parallel.day != p.day then
                parallel.day = p.day
                parallel.save!
              end
            
              if parallel.first_hour != p.first_hour then
                parallel.first_hour = p.first_hour
                parallel.save!
              end
            
              if parallel.last_hour != p.last_hour then
                parallel.last_hour = p.last_hour
                parallel.save!
              end
              
              if parallel.number != p.parallel_number then
                parallel.number = p.parallel_number
                parallel.save!
              end
            
              if parallel.parity != p.parity then
                parallel.parity = p.parity
                parallel.save!
              end
            
              if parallel.parallel_type != p.type then
                parallel.parallel_type = p.type
                parallel.save!
              end
              
              if !p.room.nil? and parallel.room != Room.find_by_code(p.room.code) then
                parallel.room = Room.find_by_code(p.room.code)
                parallel.save!
              end
            
              #TODO
              process_related(parallel,p,"teachers")
              updated_parallels+=1
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