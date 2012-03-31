module UsersHelper
  
  def full_url_user(peoples)
    return if peoples.nil?
    u = []
    peoples.each do |l|
      name = "#{l.firstname} #{l.lastname}"
      name = l.login if l.lastname.nil?
      u << link_to_if(can?(:show,User),name, :controller=>"users", :action=>"show", :id=>l.id)
    end
    u.join(", ").html_safe
  end
  
  def roles(user)
    user.roles.collect{|i| t(i,:scope=>"roles")}.join(", ")
  end
  
  def input_roles
    roles = User::ROLES.clone
    roles.delete("root") if cannot?(:root,User)
    
    return roles.collect{|item| 
      [t(item, :scope=>"roles"),item]
    }
  end
end
