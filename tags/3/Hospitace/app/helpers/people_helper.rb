# encoding: utf-8

module PeopleHelper
  def short_peoples(peoples)
    return if peoples.nil?
    return unless peoples.is_a? Array
    u = []
    peoples.each do |l|
      (next u << l.login) if l.lastname.nil?
      u << "#{l.firstname[0]}. #{l.lastname}"
    end
    u.join(", ")
  end
   
  def full_url_peoples(peoples)
    return if peoples.nil?
    return unless peoples.is_a? Array
    peoples.collect do |l|
      full_url_people(l)
    end.join(", ").html_safe
  end
  
  def full_url_people(people)
    return if people.nil?
    name = "#{people.firstname} #{people.lastname}"
    name = people.login if people.lastname.nil?
    link_to_if(can?(:show,People),name, people)
  end
  
  def roles(user)
    user.roles.collect{|i| t(i,:scope=>"roles")}.join(", ")
  end
  
  def input_roles
    input_all_roles do |roles|
      roles.delete("root") if cannot?(:root,Role)
    end
  end
  
  def input_all_roles
    roles = Role::ROLES.clone
    yield(roles) if block_given?
    return roles.collect{|item| 
      [t(item, :scope=>"roles"),item]
    }
  end
end