# encoding: utf-8

require 'lib/kosapi'

namespace :import do
  task :course => :environment do
    beginning = Time.now
    
    Event.create(
      :date   => DateTime.now,
      :text   => 'Zahájen import předmětů, rozvrhových paralelek a osnov z KOSu.',
      :entity => 'import')
    
    faculty_role = FacultyRole.find_by_code "SFR"
    syllabus = Syllabus.find_by_code "SI"
    
    current_semester = Semester.find_by_code KOSapi::Semester.current_semester.code
    
    prednaska = PlannedWeekTopicType.find_by_value 'přednáška importovaná z KOSu'
    cviceni = PlannedWeekTopicType.find_by_value 'cvičení importované z KOSu'
    
    def convert_parallel_type type
      case type
        when 'LABORATORY'
          ParallelClassType.find_by_value 'laboratoř'
        when 'LECTURE'
          ParallelClassType.find_by_value 'přednáška'
        when 'PROJECT'
          ParallelClassType.find_by_value 'projekt'
        when 'PT_COURSE'
          ParallelClassType.find_by_value 'TV kurz'
        when 'SEMINAR'
          ParallelClassType.find_by_value 'seminář'
        when 'TUTORIAL'
          ParallelClassType.find_by_value 'cvičení'
      end
    end
    
    def convert_parity parity
      case parity
        when 'BOTH'
          ParallelClassParity.find_by_value('both')
        when 'EVEN'
          ParallelClassParity.find_by_value('even')
        when 'ODD'
          ParallelClassParity.find_by_value('odd')
      end
    end
    
    def convert_day day
      case day
        when 'MONDAY'
          1
        when 'TUESDAY'
          2
        when 'WEDNESDAY'
          3
        when 'THURSDAY'
          4
        when 'FRIDAY'
          5
        when 'SATURDAY'
          6
        when 'SUNDAY'
          7
        else
          0
      end
    end
    
    def import_week weeks, first, type, subject, course
      i = 1
      weeks.each do |week|
        p = PlannedWeekTopic.create(
          :week                     => i,
          :topic                    => week,
          :is_first                 => first,
          :note                     => nil,
          :planned_week_topic_type  => type,
          :date                     => Time.now,
          :subject                  => subject)
        i += 1
      end
    end
    
    course_count = KOSapi::Course.all.size
    
    item = 0
    KOSapi::Course.all.each do |course|
      item += 1
      puts "Course #{item}/#{course_count}"
      if course.instance.nil? then # skip courses which arent this semester
        puts "Skipping course with code: #{course.code}"
        next
      end
      
      teacher = if !course.instance.nil? && !course.instance.guarantors[0].nil? then
                  User.find_by_username(course.instance.guarantors[0].username).id
                elsif !course.instance.nil? && !course.instance.lecturers[0].nil?
                  User.find_by_username(course.instance.lecturers[0].username).id
                else
                  0
                end
                
      s = Subject.find_by_code_and_semester_id course.code, current_semester.id
      puts "Processing course with code: #{course.code}"
      if s.nil? then
        s = Subject.create(
          :code               => course.code,
          :name               => course.name,
          :syllabus           => syllabus,
          :faculty_role       => faculty_role,
          :main_teacher_id    => teacher,
          :semester           => current_semester)
        
        #begin PlannedWeekTopic
        
        course.instance.instructors.each do |instr|
          user = User.find_by_username(instr.username)
          if not s.possible_teachers.exists? user then
            s.possible_teachers << user
          end
        end
        
        s.save!
        
        import_week course.lecture_syllabus, true, prednaska, s, course
        import_week course.lecture_syllabus, false, prednaska, s, course
        import_week course.practise_syllabus, true, cviceni, s, course
        import_week course.practise_syllabus, false, cviceni, s, course
        
        #end PlannedWeekTopic
        
        course.instance.parallels.each do |parallel|
          room = Room.find_by_code parallel.room.code
          
          p = ParallelClass.create(
            :day                    => convert_day(parallel.day),
            :hour_start             => parallel.first_hour,
            :hour_end               => parallel.last_hour,
            :subject                => s,
            :parallel_class_type    => convert_parallel_type(parallel.type),
            :room                   => room,
            :parallel_number        => parallel.id,
            :parallel_class_parity  => convert_parity(parallel.parity))
          
          parallel.teachers.each do |teacher|
            Visit.create(:user => User.find_by_username(teacher.username), :parallel_class => p, :is_teaching => true)
          end
        
          parallel.students.each do |student|
            Visit.create(:user => User.find_by_username(student.username), :parallel_class => p)
          end
        end
      else
        puts "Updating a course with code: #{course.code}"
        
        ActiveRecord::Base.connection.execute("DELETE v.* FROM visits v JOIN parallel_classes p ON v.parallel_class_id = p.id JOIN subjects s ON p.subject_id = s.id WHERE semester_id = #{current_semester.id} AND s.code = '#{s.code}'")
        
        if s.name != course.name then
          s.name = course.name
          s.save!
        end
        
        if s.syllabus != syllabus then
          s.syllabus = syllabus
          s.save!
        end
        
        if s.faculty_role != faculty_role then
          s.faculty_role = faculty_role
          s.save!
        end
        
        if s.main_teacher_id != teacher then
          s.main_teacher_id = teacher
          s.save!
        end
        
        s.possible_teachers.clear
        
        course.instance.instructors.each do |instr|
          user = User.find_by_username(instr.username)
          if not s.possible_teachers.exists? user then
            s.possible_teachers << user
          end
        end
        
        PlannedWeekTopic.delete_all "subject_id = #{s.id} AND is_first = 0"
        
        import_week course.lecture_syllabus, false, prednaska, s, course
        import_week course.practise_syllabus, false, cviceni, s, course
        
        course.instance.parallels.each do |parallel|
          room = Room.find_by_code parallel.room.code
          
          p = ParallelClass.find_by_parallel_number(parallel.id)
          if p.nil? then
            p = ParallelClass.create(
              :day                    => convert_day(parallel.day),
              :hour_start             => parallel.first_hour,
              :hour_end               => parallel.last_hour,
              :subject                => s,
              :parallel_class_type    => convert_parallel_type(parallel.type),
              :room                   => room,
              :parallel_number        => parallel.id,
              :parallel_class_parity  => convert_parity(parallel.parity))
            
            parallel.teachers.each do |teacher|
              Visit.create(:user => User.find_by_username(teacher.username), :parallel_class => p, :is_teaching => true)
            end
            
            parallel.students.each do |student|
              Visit.create(:user => User.find_by_username(student.username), :parallel_class => p)
            end
          else
            # Visit.delete_all "parallel_class_id = #{p.id}"
            
            if p.day != convert_day(parallel.day) then
              p.day = convert_day(parallel.day)
              p.save!
            end
            
            if p.hour_start != parallel.first_hour then
              p.hour_start = parallel.first_hour
              p.save!
            end
            
            if p.hour_end != parallel.last_hour then
              p.hour_end = parallel.last_hour
              p.save!
            end
            
            if p.subject != s then
              p.subject = s
              p.save!
            end
            
            if p.parallel_class_type != convert_parallel_type(parallel.type) then
              p.parallel_class_type = convert_parallel_type(parallel.type)
              p.save!
            end
            
            if p.room != room then
              p.room = room
              p.save!
            end
            
            if p.parallel_class_parity != convert_parity(parallel.parity) then
              p.parallel_class_parity = convert_parity(parallel.parity)
              p.save!
            end
            
            parallel.teachers.each do |teacher|
              Visit.create(:user => User.find_by_username(teacher.username), :parallel_class => p, :is_teaching => true)
            end
            
            parallel.students.each do |student|
              Visit.create(:user => User.find_by_username(student.username), :parallel_class => p)
            end
          end
        end
      end
    end
    
    final = Time.now - beginning
    Event.create(
      :date   => DateTime.now,
      :text   => "Dokončen import předmětů, rozvrhových paralelek a osnov z KOSu, " +
                  "celkem naimportováno #{course_count} předmětů. " +
                  "Import trval #{final} vteřin.",
      :entity => 'import')
  end
end