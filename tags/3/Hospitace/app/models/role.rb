class Role < ActiveRecord::Base
  ROLES = %w[admin observer observed root]
  
  belongs_to :people
  has_many :observers, :through => :people
  
  validates :people_id, :uniqueness => true
  #attr_accessible :roles,:people,:people_id,:roles_mask
  
  after_find :load_rules
  
  def load_rules
    self.role="observer" unless observers.empty?
    self.role="observed" if people.observed.any?    
    save
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
end
