class Ability
  include CanCan::Ability

  attr_reader :current_user

  def initialize(user)
    
    @current_user = user || User.new # for guest
    @current_user.roles.each { |role| send(role) }

    if @current_user.roles.size == 0
      guest
    end
    
    if @current_user.persisted?
      logged
    end
    
  end
  
  def guest
    can [:new, :create], UserSession
    can [:new, :create], User
  end
  
  def logged
    can [:destroy], UserSession
    can [:edit], User, :id => current_user.id
  end
  
  def observed
    logged
  end
  
  def observer
    logged
  end
  
  def admin
    can :manage, :all
  end
end
