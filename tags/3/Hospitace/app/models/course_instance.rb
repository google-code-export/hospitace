# encoding: utf-8

class CourseInstance < ActiveRecord::Base
  belongs_to :course
  belongs_to :semester
  
  validates_uniqueness_of :course_id, :scope => :semester_id
  
  has_many :peoples_relateds, :as => :related, :class_name => "PeoplesRelated"
  
  has_many :editors, :through => :peoples_relateds, :source => :editor, :conditions => "peoples_relateds.relation = 'editors'"
  has_many :examiners, :through => :peoples_relateds, :source => :examiner, :conditions => "peoples_relateds.relation = 'examiners'"
  has_many :guarantors, :through => :peoples_relateds, :source => :guarantor, :conditions => "peoples_relateds.relation = 'guarantors'"
  has_many :instructors, :through => :peoples_relateds, :source => :instructor, :conditions => "peoples_relateds.relation = 'instructors'"
  has_many :lecturers, :through => :peoples_relateds, :source => :lecturer, :conditions => "peoples_relateds.relation = 'lecturers'"
  
  has_many :parallels
end
