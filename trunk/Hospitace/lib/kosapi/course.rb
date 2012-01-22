require 'date'

module KOSapi
  class Course < Resource
    RESOURCE = "#{API_URI}courses/"
    
    attrs_with_translate :classes_type,:completion, :status, :study_form, :semester_season
    
    attr_reader :allowed_enrollment_count # povolený počet zapsání
    attr_reader :approval_date # Datum schválení předmětu.
    attr_reader :classes_lang # výukový jazyk
    attr_reader :lecture_syllabus # osnova přednášek
    attr_reader :practise_syllabus # osnova cvičeních 
    attr_reader :objectives # Cíle výuky podle ECTS 
    attr_reader :range # rozsah výuky
    attr_reader :note
    attr_reader :id, :code, :credits, :description, :keywords, :literature, :name, :requirements
    
    @@all = nil

    def self.all
      return @@all if not @@all.nil?
      pure_data = get("#{RESOURCE}?#{PARAM}")
      return Array[] if pure_data.nil?
      data_courses = pure_data['course']
      return Array[] if data_courses.nil?
      if data_courses.kind_of? Hash then
        @@all ||= Array[self.new data_courses]
      else
        @@all ||= data_courses.collect {|course| self.new course}
      end
    end
    
    def self.find_by_code code
      data_course = get("#{RESOURCE}#{code}?#{PARAM}")
      self.new(data_course)
    end

    def initialize(course)
      return unless valid? course
      
      @id = course['@id']
      @allowed_enrollment_count = course['allowedEnrollmentCount'].to_i
      @approval_date = Date.parse(course['approvalDate']) unless course['approvalDate'].nil?
      @classes_lang = course['classesLang']
      @classes_type = course['classesType']
      @lecture_syllabus = convert_lines course['lecturesContentsCz']
      @practise_syllabus = convert_lines course['tutorialsContentsCz']
      @objectives = course['objectivesCz']
      @range = course['range']
      @semester_season = course['semesterSeason']
      @status = course['status']
      @study_form = course['studyForm']
      @code = course['code']
      @completion = course['completion']
      @credits = course['credits'].to_i
      @description = convert_lines course['descriptionCz']
      @keywords = course['keywordsCz']
      @literature = convert_lines course['literatureCz']
      @name = course['nameCz']
      @requirements = convert_lines course['requirementsCz']
      @note = convert_lines course['noteCz']
      @uri = course['@uri']
    end
    
    def instance semester_code=nil
      return @instance if not @instance.nil?
      semester_code ||= Semester.current_semester.code
      data_instance = Course.get("#{RESOURCE}#{@code}/instances/#{semester_code}?level=2")
      return if data_instance.nil?
      @instance ||= CourseInstance.new data_instance
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
  end
end