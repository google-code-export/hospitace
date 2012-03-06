class Form < ActiveRecord::Base
  belongs_to :evaluation
  belongs_to :user
  belongs_to :form_template
  has_many :entries, :dependent => :destroy
  
  has_one :observation, :through => :evaluation
  
  validates :form_template, :presence => true 
  validates :user, :presence => true 
  validates :evaluation, :presence => true 
  
  def can_create?(observation)
    return false if observation.nil? or form_template.nil? 
  end
end
