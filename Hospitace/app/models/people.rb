class People < ActiveRecord::Base
  include EmailTemplatesHelper::Tagged::ModelHelpers
  
  has_one :user
  has_many :peoples_relateds

  validates :username, :uniqueness => true
  
  def observed
    Observation.find(:all,
            :joins => "inner join peoples_relateds on observations.parallel_id = peoples_relateds.related_id and peoples_relateds.relation='teachers' and peoples_relateds.related_type='Parallel' inner join people on people.id = peoples_relateds.people_id",
            :conditions => ["people_id = ?", id],
            :include => [:created_by,:users,:course]
    )
  end
  
  def full_name
      "#{title_pre} #{firstname} #{lastname} #{title_post}"
  end
  
  
  def self.search(search)  
    if search  
      query,data = [],[]
      
      search.each do |key,value|  
        next if key == "teacher" and value == 0.to_s
        next if value == "" or value == 0 
        
        if key == "name"
          query << "concat(firstname, ' ' , lastname) LIKE ?"
          data << "%#{value}%"
        else
          query <<  " #{key} LIKE ?"
          data << "%#{value}%"
        end
      end 
      where(query.join(' AND'),*data)
    else  
      scoped  
    end
  end 
  
  alias_method :name,:full_name 
  alias_method :to_lable,:full_name 
  attrs_tagged :name, :email, :username
end