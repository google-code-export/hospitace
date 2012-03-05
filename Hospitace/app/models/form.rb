class Form < ActiveRecord::Base
  belongs_to :evaluation
  belongs_to :user
  belongs_to :form_template
  has_many :entries, :dependent => :destroy
  
  has_one :observation, :through => :evaluation
  
  def self.exist_form(evaluation,template_id)
    
  end
end
