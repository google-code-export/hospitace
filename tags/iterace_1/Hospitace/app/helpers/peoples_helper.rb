module PeoplesHelper
  def short_users(users)
    u = []
    users.each do |l|
      (next u << l.login) if l.lastname.nil?
      u << "#{l.firstname} #{l.lastname}"
    end
    u.join(", ")
  end
  
  def full_url_peoples(peoples)
    return if peoples.nil?
    u = []
    peoples.each do |l|
      name = "#{l.firstname} #{l.lastname}"
      name = l.login if l.lastname.nil?
      u << link_to_if(can?(:show,People),name, :controller=>"peoples", :action=>"show", :id=>l.id)
    end
    u.join(", ").html_safe
  end
end