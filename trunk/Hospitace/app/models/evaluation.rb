class Evaluation < ActiveRecord::Base
  belongs_to :observation 
  has_many :observers, :through=> :observation
  has_many :users, :through=> :observation
  has_many :forms, :dependent => :destroy
  
  validates :observation, :presence => true
  validates :teacher, :presence => true
  validates :course, :presence => true
  validates :guarant, :presence => true
  validates :room, :presence => true
  validates :datetime_observation, :presence => true
  
  
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
  
end
