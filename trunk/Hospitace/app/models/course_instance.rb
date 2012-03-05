class CourseInstance < ActiveRecord::Base
  belongs_to :course
  belongs_to :semester
  
  validates_uniqueness_of :course_id, :scope => :semester_id
  
  has_many :peoples_relateds, :as => :related, :class_name => "PeoplesRelated"
  
  has_many :editors, :through => :peoples_relateds, :source => :editor, :conditions => "peoples_relateds.relation = 'editors'" #:as => :related, :class_name => "PeoplesRelated"
  has_many :examiners, :through => :peoples_relateds, :source => :examiner, :conditions => "peoples_relateds.relation = 'examiners'" #:as => :related, :class_name => "PeoplesRelated"
  has_many :guarantors, :through => :peoples_relateds, :source => :guarantor, :conditions => "peoples_relateds.relation = 'guarantors'" #:as => :related, :class_name => "PeoplesRelated"
  has_many :instructors, :through => :peoples_relateds, :source => :instructor, :conditions => "peoples_relateds.relation = 'instructors'" #:as => :related, :class_name => "PeoplesRelated"
  has_many :lecturers, :through => :peoples_relateds, :source => :lecturer, :conditions => "peoples_relateds.relation = 'lecturers'" #:as => :related, :class_name => "PeoplesRelated"
  
  #select * from people inner join peoples_relateds on (people.id = peoples_relateds.people_id and peoples_relateds.relation="teachers" and peoples_relateds.related_type="Parallel") inner join observations on (peoples_relateds.related_id = observations.course_id) where users.id = 33976000
  
  has_many :parallels
end
