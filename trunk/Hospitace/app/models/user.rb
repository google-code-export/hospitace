require 'kosapi'

class User < ActiveRecord::Base
  attr_accessible :roles
  attr_accessible :login, :password, :password_confirmation
  
  attr_reader :email, :firstname, :lastname, :title_pre, :title_post
  
  
  validates :login, :uniqueness => true

  after_find :load_user

  def load_user
    user = People.find_by_username(self.login)
    @email = user.email
    @firstname = user.firstname
    @lastname = user.lastname
    @title_pre = user.title_pre
    @title_post = user.title_post
  end
  
  def full_name
    "#{@title_pre} #{@firstname} #{@lastname} #{@title_post}"
  end

  ROLES = %w[admin observer observed]
  acts_as_authentic
  def roles=(roles)
    self.roles_mask = self.class.roles(roles)#= (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
    ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def self.roles(roles)
    ret = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def self.search(search)  
    if search  
      query,data = [],[]
      
      search.each do |key,value|
        value = (key == "roles") ? self.roles(value) : value    
        next if value == "" or value == 0
        
        query << ((key == "roles") ? " roles_mask & ? > 0": " #{key} LIKE ?")
        data << ((key == "roles") ? value : "%#{value}%")
      end 
      where(query.join(' AND'),*data)
    else  
      scoped  
    end  
  end 
end
