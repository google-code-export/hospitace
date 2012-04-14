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
    u = []
    peoples.each do |l|
      name = "#{l.firstname} #{l.lastname}"
      name = l.login if l.lastname.nil?
      u << link_to_if(can?(:show,People),name, :controller=>"peoples", :action=>"show", :id=>l.id)
    end
    u.join(", ").html_safe
  end
end