require 'date'

module KOSapi
  class Parallel < Resource
    RESOURCE = "#{API_URI}courses/"
    RESOURCE_PART = "/instances/"
    
    attr_reader :id, :course_instance, :day, :first_hour, :last_hour, :parallel_code, :parallel_name, :parallel_number,
                :parity, :related_laboratory, :related_lecture, :related_practise, :room, :teachers, :type

    def initialize(parallel)
      return unless valid? parallel
      
      @id = parallel['@id']
      @course_instance = CourseInstance.new parallel['courseInstance']
      @day = parallel['day']
      @first_hour = parallel['firstHour'].to_i
      @last_hour = parallel['lastHour'].to_i
      @parallel_code = parallel['parallelCode']
      @parallel_name = parallel['parallelName']
      @parallel_number = parallel['parallelNumber'].to_i
      @parity = parallel['parity']
      @related_laboratory = parallel['relatedLaboratory'].to_i
      @related_lecture = parallel['relatedLecture'].to_i
      @related_practise = parallel['relatedTutorial'].to_i
      @room = Room.new parallel['room']
      @teachers = convert_users parallel['teachers']
      @type = parallel['type']
      @uri = parallel['@uri']
    end
    
    def students
      return @students if not @students.nil?
      uri = "#{resource_uri}#{@id}/students/?#{PARAM}"
      @students ||= convert_users Parallel.get(uri)
    end
    
    def self.find course,id
      data_parallel = get("#{RESOURCE}#{course}#{RESOURCE_PART}#{Semester.current_semester.code}/parallels/#{id}?#{PARAM}")
      self.new(data_parallel)
    end
     
    private
      def convert_lines line
        return Array[] if line.nil?
        lines = line['line']
        if lines.kind_of? String then
          lines = Array[lines]
        end
        lines
      end
      
      def resource_uri
        "#{RESOURCE}#{@course_instance.course.code}#{RESOURCE_PART}#{Semester.current_semester.code}/parallels/"
      end
  end
end