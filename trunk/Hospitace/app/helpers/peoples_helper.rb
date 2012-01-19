module PeoplesHelper
  def short_users(users)
    u = []
    users.each do |l|
      u << l.lastname
    end
    u.join(", ")
  end
  
  def full_url_peoples(peoples)
    return if peoples.nil?
    u = []
    peoples.each do |l|
      u << link_to(l.full_name, :controller=>"peoples", :action=>"show", :id=>l.id)
    end
    u.join(", ").html_safe
  end
end