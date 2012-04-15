# encoding: utf-8

module PeoplesHelper
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
    link_to_if(can?(:show,People),name, :controller=>"peoples", :action=>"show", :id=>people.id)
  end
end