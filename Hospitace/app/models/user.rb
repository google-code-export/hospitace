class User < ActiveRecord::Base
  

  attr_accessible :roles
  attr_accessible :email, :password, :password_confirmation
  
  validates :email, :uniqueness => true

  ROLES = %w[admin observer observed]
  acts_as_authentic
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
    ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def self.search(search)  
    if search  
      query = []
      data = []
      
      search.each do |key,value|
        query << " ? LIKE ?"
        data << key
        data << "%#{value}%"
      end 
      
      #where(query.join(' AND'),data)
      scoped
    else  
      scoped  
    end  
  end 
end
