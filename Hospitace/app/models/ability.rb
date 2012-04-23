# encoding: utf-8

class Ability
  include CanCan::Ability

  attr_reader :current_user

  def initialize(user)
    
    @current_user = user || People.new # for guest
    
    Role.create(:people=>@current_user,:roles_mask=>0) unless @current_user.role
    role = @current_user.role

    if role.nil?
      guest
    elsif role.roles.size == 0
      guest
    end
      
    
    if @current_user.persisted?
      logged
    end
    

    role.roles.each { |r| send(r) } unless role.nil?

    
  end
  
  def guest
    can [:read], Evaluation
    can [:read], Form do |form|
      form.form_template.read_mask == 0 unless form.form_template.nil?
    end
  end
  
  def logged
    guest
    can [:show, :show_email], People
    can [:destroy], UserSession
    can [:read], Observation
    can [:update,:show], People, :id => current_user.id
    
    can [:read, :show], Note
    can [:update], Note, :people_id => current_user.id
    
    can [:read], Evaluation
  end
  
  def observed
    logged
    can [:read,:observed], Observation
    
    can [:read], Form do |form|
      form.form_template.read?("observed")
    end
    can [:manage], Form do |form|
      form.form_template.create?("observed") unless form.form_template.nil?
    end
  end
  
  def observer
    logged
    can [:select], People
    can [:read,:observing], Observation
    can [:read],Observer
    
    can [:manage], Evaluation do |e|
      unless(e.observation.nil?)
        current_user.observations.where(:id=>e.observation.id).any? and
          e.observation.state.is_a?(Observation::States::Scheduled) 
      else
        true
      end  
    end
    
    can [:read], Form do |form|
      puts form.inspect
      form.form_template.read?("observer") and 
        form.observers.where(:people_id=>current_user.id).exists?
    end
  
    can [:update], Form do |form|
      form.form_template.create?("observer") and 
        form.people == current_user
    end
    
    can [:create,:new], Form do |form|
      form.form_template.user_create?(current_user,form.evaluation)  
    end
    
    can [:create,:read], Attachment
    can [:destroy], Attachment do |a|
      a.people == current_user
    end
  end
  
  def admin
    logged
    can :assign_roles, People
    
    # kos
    can :manage, People
    can :manage, Course
    can :manage, Parallel
    
    # setting
    can :setting, "Setting"
    
    # users
    can [:manage,:change_login], People
    cannot [:root], People
    cannot [:update,:edit,:destroy], People do |user|
      user.is?("root")
    end
    
    # observation
    can :manage, Observation
    cannot :manage, Observation do |ob|
      !(ob.created_by==current_user)
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
      n.observation.created_by == current_user
    end
    
    # evaluation
    can [:manage], Evaluation do |e|
      unless(e.observation.nil?)
        current_user.created_observations.where(:id=>e.observation.id).any? and
          e.observation.state.is_a?(Observation::States::Scheduled)
      else
        false
      end  
    end
    
    # documents
    can [:read], Form do |form|
      form.observation.created_by == current_user #.where(:user_id=>current_user.id).any?
    end
    can [:manage], Form do |form|
      form.form_template.create?("admin") and 
        form.evaluation.observation.created_by == current_user
    end
    can [:update], Form
    
    #attachmets
    can [:manage], Attachment
    
  end
  
  def root
    can :manage, :all
  end
end
