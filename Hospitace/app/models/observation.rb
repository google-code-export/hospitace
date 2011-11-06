class Observation < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :presence => true
  validates :paraller, :presence => true
  validates :week, :presence => true
  validates :course, :presence => true
  
  validation_group :step1, :fields=>[:user]
  validation_group :step2, :fields=>[:course]
  validation_group :step3, :fields=>[:paraller,:week]
  validation_group :confirmation, :fields=>:all
end
