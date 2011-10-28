require 'date'

module KOSapi
  class Semester < Resource
    RESOURCE = "#{API_URI}dumps/semesters"
    
    attr_reader :id, :code, :name, :start, :end
    
    @@current_semester = nil
    @@all = nil

    def self.all
      return @@all if not @@all.nil?
      pure_data = get("#{RESOURCE}")
      return if pure_data.nil?
      data_semesters = pure_data['semester']
      return if data_semesters.nil?
      if data_semesters.kind_of? Hash then
        @@all ||= Array[self.new data_semesters]
      else
        @@all ||= data_semesters.collect {|semester| self.new semester}
      end
    end
    
    def self.current_semester
      return @@current_semester if not @@current_semester.nil?
      current_semester_code = "B101"
      return if Semester.all.nil?
      Semester.all.each do |semester|
        if semester.code == current_semester_code
          return @@current_semester ||= semester
        end
      end
    end

    def initialize(semester)
      # dumps doesnt have url so cant be check whether data are valid
      @id = semester['@id']
      @code = semester['code']
      @name = semester['nameCz'] # also nameEn but systems on FEL CVUT are CZ only
      @start = Date.parse(semester['startDate']) unless semester['startDate'].nil?
      @end = Date.parse(semester['endDate']) unless semester['startDate'].nil?
    end
  end
end