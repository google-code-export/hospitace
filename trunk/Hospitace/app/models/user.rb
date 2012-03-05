require 'kosapi'

class User < ActiveRecord::Base
  
  #scope :observ, joins(:observers).sum(:observation_id).group(:user_id)
  
  belongs_to :people
  
  has_many :notes
  
  has_many :created_observations, :class_name => "Observation", :foreign_key=>:created_by
  
  has_many :observers
  has_many :observations, :through => :observers
  
  attr_accessible :roles
  attr_accessible :login, :password, :password_confirmation, :people_id
  
  attr_reader :username,:email, :firstname, :lastname, :title_pre, :title_post
  
  validates :people_id, :uniqueness => true
  validates :login, :uniqueness => true

  #after_find :load_people
  after_find :load_rules

  def email
    return people.email unless people.nil?
  end
  
  def full_name
    return people.full_name unless people.nil?
  end
  
  def firstname
    return people.firstname unless people.nil?
  end
  
  def lastname
    return people.lastname unless people.nil?
  end
  
  def username
    return people.username unless people.nil?
  end

  ROLES = %w[admin observer observed root]
  
  acts_as_authentic
  def load_rules
    self.role="observer" unless observers.empty?
    unless people.nil?
      self.role="observed" if people.observed.any?
    end    
  end
  
  def roles=(roles)
    self.roles_mask = self.class.roles(roles)
  end
  
  def role=(role)
    self.roles_mask = roles_mask | 2**ROLES.index(role)
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
