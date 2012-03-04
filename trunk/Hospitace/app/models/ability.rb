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
    can [:read], Evaluation
  end
  
  def logged
    can [:show], People
    can [:show], User
    can [:destroy], UserSession
    can [:read], Observation
    can [:update,:show], User, :id => current_user.id
    
    can [:read], Note
    can [:update], Note, :user_id => current_user.id
    
    can [:read], Evaluation
  end
  
  def observed
    logged
    can [:read], Form
    can [:manage], Form do |form|
      form.form_template.is?("observed") unless form.form_template.nil?
    end
  end
  
  def observer
    logged
    can [:read,:observing], Observation
    can [:read],Observer
    
    can [:manage], Evaluation do |e|
      unless(e.observation.nil?)
        current_user.observations.where(:id=>e.observation.id).any?
      else
        true
      end  
    end
    
    can [:read], Form
    can [:manage], Form do |form|
      form.form_template.is?("observer") unless form.form_template.nil?
    end
    
  end
  
  def admin
    logged
    can :assign_roles, User
    
    # kos
    can :manage, People
    can :manage, Course
    can :manage, Parallel
    
    # setting
    can :setting, "Setting"
    
    # users
    can [:manage,:change_login], User
    cannot [:root], User
    cannot [:update,:edit,:destroy], User do |user|
      user.is?("root")
    end
    
    # observation
    can :manage, Observation
    cannot :manage, Observation do |ob|
      !(ob.created_by.id==current_user.id)
    end
    can :create, Observation
    can [:read,:observing], Observation
    can :m_ob, Observation
    
    # observers
    can :manage, Observer
    
    # notes
    can [:create, :new], Note
    cannot [:update], Note
    can [:destroy], Note do |n|
      n.observation.created_by == current_user.id
    end
    
    # evaluation
    can [:manage], Evaluation do |e|
      unless(e.observation.nil?)
        current_user.created_observations.where(:id=>e.observation.id).any?
      else
        false
      end  
    end
    # documents
    can [:read], Form
    can [:manage], Form do |form|
      form.form_template.is?("admin") unless form.form_template.nil?
      false
    end
  end
  
  def root
    can :manage, :all
  end
end
