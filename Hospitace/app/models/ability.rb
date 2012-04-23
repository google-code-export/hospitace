# encoding: utf-8

class Ability
  include CanCan::Ability

  attr_reader :current_user

  def initialize(user)
    
    @current_user = user || People.new # for guest
    
    @current_user.role ||= Role.new(:people=>@current_user,:roles_mask=>0)
    @current_user.save! if @current_user.persisted?
    role = @current_user.role

    if role.nil?
      guest
    elsif role.roles.size == 0
      guest
    end
      
  

    role.roles.each { |r| send(r) } unless role.nil?

    can :show, "Errors"
  end
  
  def guest
    can [:show], People 
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
    can [:read], Observation
    
  end
  
  def observed
    logged
    form
    
    can [:read,:observed], Observation
  end
  
  def observer
    logged
    form
    
    can [:select], People
    can [:read,:observing], Observation
    can [:read],Observer
    
    can [:create,:new], Evaluation do |e|
      unless(e.observation.nil?)
        current_user.observations.where(:id=>e.observation.id).any? and
          e.observation.state.is_a?(Observation::States::Scheduled) 
      else
        true
      end  
    end
  
  end
  
  def admin
    logged
    note
    
    observation
    evaluation
    
    can :assign_roles, People
    
    # kos
    can :manage, People
    can :manage, Course
    can :manage, Parallel
    
    # setting
    can :setting, "Setting"
    
    # users
    can [:manage], People
    cannot [:root], People
    cannot [:update,:edit,:destroy], People do |user|
      user.is?("root")
    end  
    
    # documents
    can [:manage], Form do |form|
      form.observation.created_by == current_user
    end
    can [:index], Form
    
    #attachmets
    can [:manage], Attachment do |a|
      a.evaluation.administrator == current_user if a.evaluation
    end
    
  end
  
  def root
    can :manage, :all
  end
  
  
  
  
  
   
  #
  #
  #
  def form
    can [:show], Form do |form|
      form.form_template.user_read?(current_user,form.evaluation)
    end
    
    can [:create,:new], Form do |form|
      form.form_template.user_create?(current_user,form.evaluation)
    end
    
    can [:update], Form do |form|
      form.people == current_user
    end
    
    can [:create,:read], Attachment do |a|
      !a.evaluation.user_role(current_user).empty?
    end
    can [:destroy], Attachment do |a|
      a.people == current_user
    end
  end
  
  
  #
  #
  #
  def note
    can [:create, :new], Note do |n|
      n.observation.created_by == current_user
    end
    
    cannot [:update], Note
    can [:destroy], Note do |n|
      n.observation.created_by == current_user
    end
  end
  
  #
  #
  #
  def evaluation   
    can :manage, Evaluation do |e|
      e.administrator == current_user
    end
    
    can [:manage], Evaluation do |e|
      unless(e.observation.nil?)
        current_user.created_observations.where(:id=>e.observation.id).any? and
          e.observation.state.is_a?(Observation::States::Scheduled)
      else
        false
      end  
    end
  end
  
  #
  #
  #
  def observation
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
  end
end
