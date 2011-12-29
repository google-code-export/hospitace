require 'date'

module KOSapi
  class CourseInstance < Resource
    RESOURCE = "#{API_URI}courses/" # followed by course code
    RESOURCE_PART = "/instances/" # followed by semester code
    
    attr_reader :id, :capacity, :capacity_overfill, :course, :editors, 
                :examiners, :guarantors, :instructors, :lecturers, :occupied
    
    def self.find_by_course_code code
      data_instance = get("#{resource_uri}?level=2")
      self.new(data_instance)
    end

    def initialize(instance)
      return unless valid? instance
      
      @id = instance['@id']
      @capacity = instance['capacity'].to_i
      @capacity_overfill = instance['capacityOverfill']
      @course = Course.new instance['course']
      @editors = convert_users instance['editors']
      @examiners = convert_users instance['examiners']
      @guarantors = convert_users instance['guarantors']
      @instructors = convert_users instance['instructors']
      @lecturers = convert_users instance['lecturers']
      @occupied = instance['occupied'].to_i
    end
    
    def students
      return @students if not @students.nil?
      uri = CourseInstance.get("#{resource_uri}students/?#{PARAM}")
      @students ||= convert_users uri
    end
    
    def parallels
      return @parallels if not @parallels.nil?
      pure_data = CourseInstance.get("#{resource_uri}parallels?level=3")
      return Array[] if pure_data.nil?
      data_parallel = pure_data['parallel']
      return Array[] if data_parallel.nil?
      if data_parallel.kind_of? Hash then
        @parallels ||= Array[Parallel.new data_parallel]
      else
        @parallels ||= data_parallel.collect {|parallel| Parallel.new parallel}
      end
    end
    
    private
      def resource_uri
        "#{RESOURCE}#{@course.code}#{RESOURCE_PART}#{Semester.current_semester.code}/"
      end
  end
end