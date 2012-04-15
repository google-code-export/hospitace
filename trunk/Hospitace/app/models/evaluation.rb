# encoding: utf-8

class Evaluation < ActiveRecord::Base
  include EmailTemplatesHelper::Tagged::ModelHelpers
  
  belongs_to :observation 
  belongs_to :teacher, :class_name=>"People"
  belongs_to :guarant, :class_name=>"People"
  has_many :observers, :through=> :observation
  has_many :users, :through=> :observation
  has_many :forms, :dependent => :destroy
  has_one :head_of_department, :through=> :observation
  has_one :created_by, :through=> :observation
  
  validates :observation, :presence => true
  validates :teacher, :presence => true
  validates :course, :presence => true
  validates :guarant, :presence => true
  validates :room, :presence => true
  
  alias_method :administrator, :created_by
  
  def email_for
    res = [teacher,guarant]
    res += users
    res.push head_of_department
    res.compact
  end
  
  def forms?
    :observation
  end
  
  def form?(template_code)
    template = FormTemplate.find_by_code template_code
    forms = Form.joins(:form_template).where("form_templates.code"=>template_code,:evaluation_id=>id)
    
    if(template.count.to_i.to_s==template.count)
      count = template.count.to_i
    end
    count ||= send(template.count).count 
    count == forms.count || !template.required
  end
  
  def observed
    observation.observed
  end
  
  def self.search(search)  
    scoped    
  end 
  
  validate :datetime_format_and_existence_is_valid 
  before_save :merge_and_set_datetime
  
  # virtual attributes for date and time allow strings
  # representing date and time respectively to be sent
  # back to the model where they are merged and parsed
  # into a datetime object in activerecord
  def date
    if (self.datetime_observation) then self.datetime_observation.to_date
    else @date ||= self.observation.date #default
    end
  end
  def date=(date_string)
    @date = date_string.strip
  end
  def time
    if(self.datetime_observation) then self.datetime_observation.to_time
    else @time ||= self.observation.start
    end
  end
  def time=(time_string)
    @time = time_string.strip
  end

  # if parsing of the merged date and time strings is
  # unsuccessful, add an error to the queue and fail
  # validation with a message
  def datetime_format_and_existence_is_valid    
    errors.add(:datetime_observation, 'datum musí být ve formátu DD.MM.YYYY') unless
      (@date =~ /\d\d\.( )?\d\d\.( )?\d{4}/)# check the date's format
    errors.add(:datetime_observation, 'čas musí být ve formátu HH:MM') unless # check the time's format
      (@time =~ /^((0?[1-9]|1[012])(:[0-5]\d){0,2}(\ [AaPp][Mm]))$|^(([01]\d|2[0-3])(:[0-5]\d){0,2})$/)
    # build the complete date + time string and parse
    @datetime_str = @date + " " + @time
    errors.add(:datetime_observation, "neexistuje") if 
      ((Time.zone.parse(@datetime_str) rescue ArgumentError) == ArgumentError)
  end

  # callback method takes constituent strings for date and 
  # time, joins them and parses them into a datetime, then
  # writes this datetime to the object
  private
  def merge_and_set_datetime
    self.datetime_observation = Time.zone.parse(@datetime_str) if errors.empty?
  end
end
