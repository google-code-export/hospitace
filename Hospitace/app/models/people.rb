class People < ActiveRecord::Base
  include EmailTemplatesHelper::Tagged::ModelHelpers
  
  
  has_many :notes
  
  has_many :created_observations, :class_name => "Observation", :foreign_key=>:created_by
  
  has_many :observers
  has_many :observations, :through => :observers
  
  
  
  has_one :role
  has_many :peoples_relateds

  validates :username, :uniqueness => true
  
  acts_as_authentic
  
  def observed
    Observation.find(:all,
            :joins => "inner join peoples_relateds on observations.parallel_id = peoples_relateds.related_id and peoples_relateds.relation='teachers' and peoples_relateds.related_type='Parallel' inner join people on people.id = peoples_relateds.people_id",
            :conditions => ["people_id = ?", id],
            :include => [:created_by,:roles,:course]
    )
  end
  
  def full_name
      "#{title_pre} #{firstname} #{lastname} #{title_post}"
  end
  
  def login
    username
  end
  
  def self.search(search)  
    if search  
      query,data = [],[]
      
      search.each do |key,value|  
        next if key == "teacher" and value == 0.to_s
        next if key == "roles" and value == [""]
        next if value == "" or value == 0 
        
        if key == "roles"
          query << " roles.roles_mask & ? > 0"
          data << Role.roles(value)
          next
        end
        
        if key == "name"
          query << "concat(people.firstname, ' ' , people.lastname) LIKE ?"
          data << "%#{value}%"
        else
          query <<  " people.#{key} LIKE ?"
          data << "%#{value}%"
        end
      end 
      where(query.join(' AND'),*data)
    else  
      scoped
    end
  end 
  
  def roles
    return [] unless role
    role.roles
  end
  
  alias_method :name,:full_name 
  alias_method :to_lable,:full_name 
  attrs_tagged :name, :email, :username
end

class Person < People
end