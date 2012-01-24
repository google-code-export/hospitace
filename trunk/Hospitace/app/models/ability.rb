class Ability
  include CanCan::Ability

  attr_reader :current_user

  def initialize(user)
    
    @current_user = user || User.new # for guest

    if @current_user.roles.size == 0
      guest
    end
    
    if @current_user.persisted?
      logged
    end
    
    @current_user.roles.each { |role| send(role) }

    
  end
  
  def guest
    can [:new, :create], UserSession
    can [:new, :create], User
  end
  
  def logged
    can [:show], People
    can [:show], User
    can [:destroy], UserSession
    can [:read], Observation
    can [:update,:show], User, :id => current_user.id
    can [:manage], Note, :user_id => current_user.id
  end
  
  def observed
    logged
  end
  
  def observer
    can [:read,:observing], Observation
    can [:read],Observer
    can [:read], Note
    logged
  end
  
  def admin
    can :assign_roles, User
    can :manage, :all 
    
    cannot [:root], User
    cannot [:update,:edit,:destroy], User do |user|
      user.is?("root")
    end
    
    cannot [:update], Note
    can [:destroy], Note do |n|
      n.observation.created_by == current_user.id
    end
    can [:update], Note, :user_id => current_user.id

    cannot :manage, Observation do |ob|
      !(ob.created_by.id==current_user.id)
    end
    
    can :observing, Observation
    can :m_ob, Observation
    
#    cannot :read, Observation do |ob|
#      if ob.type == :unannounced 
#        return false if ob.created_by.id !=current_user.id
#      end
#      return true
#    end

  end
  
  def root
    can :manage, :all
  end
end
